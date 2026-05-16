# Kafka ACL policy (documentation template)

Replace principals with your production identity mechanism (SASL, mTLS, etc.).

| Principal | Produce | Consume |
|-----------|---------|---------|
| svc-order | order.created.v1, order.cancelled.v1 | inventory.reserved.v1 |
| svc-inventory | inventory.reserved.v1 | order.created.v1 |
| svc-payment | payment.captured.v1 | order.cancelled.v1 |
