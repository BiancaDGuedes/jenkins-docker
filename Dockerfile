# Stage 1: Build
FROM python:3.11-slim AS build

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app/ app/
COPY tests/ tests/

RUN python -m py_compile app/*.py
RUN mkdir /build && cp -r app tests requirements.txt /build

# Stage 2: Test
FROM python:3.11-slim AS test

WORKDIR /test

COPY --from=build /build /test

RUN pip install -r requirements.txt

CMD ["python", "-m", "unittest", "discover", "-s", "tests"]
