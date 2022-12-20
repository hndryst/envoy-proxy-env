apiVersion: apps/v1
kind: Deployment
metadata:
  name: envoy-proxy
  namespace: envoy
  labels:
    app: envoy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: envoy
  template:
    metadata:
      labels:
        app: envoy
    spec:
      containers:
        - name: envoy
          image: LOCATION-docker.pkg.dev/PROJECT_ID/REPO/IMAGE:SHORT_SHA
          ports:
            - containerPort: 8080
          volumeMounts:
            - mountPath: /data
              name: envoy-data
      volumes:
        - name: envoy-data
          emptyDir:
            sizeLimit: 10Mi
---
apiVersion: v1
kind: Service
metadata:
  name: envoy-svc
  namespace: envoy
  labels:
    app: envoy
spec:
  selector:
    app: envoy
  ports:
    - port: 8080
      targetPort: 8080
  type: LoadBalancer
