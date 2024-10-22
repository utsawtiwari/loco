FROM python:3.10-slim as builder

WORKDIR /app

RUN pip install --upgrade pip

COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt

COPY . .

FROM python:3.10-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

COPY --from=builder /app /app

EXPOSE 80

CMD ["python", "loco.py"]
