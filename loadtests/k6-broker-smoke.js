import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  vus: 2,
  duration: "30s",
};

const registry = __ENV.SCHEMA_REGISTRY_URL || "http://localhost:18081";

export default function () {
  const res = http.get(`${registry}/subjects`);
  check(res, { "schema registry up": (r) => r.status === 200 });
  sleep(1);
}
