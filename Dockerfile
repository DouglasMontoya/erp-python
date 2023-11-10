FROM python:3.10-alpine3.18 as base
ARG POETRY_VERSION
ARG APP_ENV
ENV PYTHONFAULTHANDLER=1 \
  PYTHONHASHSEED=random \
  PYTHONUNBUFFERED=1

WORKDIR /app

FROM base as builder

ENV PIP_DEFAULT_TIMEOUT=100 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_NO_CACHE_DIR=1

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
  --mount=type=cache,target=/var/lib/apk,sharing=locked \
  apk add --update --no-cache gcc libffi-dev musl-dev postgresql-dev
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install "poetry==$POETRY_VERSION"
RUN python -m venv /venv

COPY pyproject.toml poetry.lock ./
RUN --mount=type=cache,mode=0777,target=/root/.cache/pypoetry \
  poetry config virtualenvs.in-project true && \
  . /venv/bin/activate && poetry install --no-root --compile \
  $(test "$APP_ENV" == production && echo "--no-dev")

COPY . .
RUN  --mount=type=cache,target=/root/.cache/pip \
  --mount=type=cache,mode=0777,target=/root/.cache/pypoetry\
  . /venv/bin/activate && \
  poetry build && \
  pip install dist/*.whl

FROM base as final

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apk add --update --no-cache libffi libpq
COPY --from=builder /venv /venv
COPY alembic.ini ./
RUN mkdir app
COPY app/alembic/ app/
CMD ["/venv/bin/python", "-m","app"]
