# 🗣️ GraphTalk - Scalable Community Discussion Platform  

GraphTalk is a **scalable, distributed discussion platform** built with **Ruby on Rails (GraphQL API), Redis caching, RabbitMQ event-driven notifications, and OpenTelemetry for distributed tracing**. This project aligns with enterprise-grade backend architectures, supporting **large-scale conversations and community engagement**.

## 📜 **Features**  
✅ **GraphQL API** for efficient data retrieval  
✅ **User Authentication & JWT-based Authorization** (Admin, Moderator, User)  
✅ **Role-Based Access Control (RBAC)** for managing permissions  
✅ **Redis Caching** for performance optimization  
✅ **RabbitMQ for Asynchronous Event-Driven Notifications**  
✅ **Grafana & Prometheus for Monitoring API Performance**  
✅ **OpenTelemetry for Distributed Tracing**  

---

## 🏗 **Tech Stack**  

| Component        | Technology Used |
|-----------------|----------------|
| **Backend API** | Ruby on Rails (GraphQL) |
| **Database** | PostgreSQL |
| **Caching** | Redis |
| **Message Queue** | RabbitMQ |
| **Monitoring** | Grafana & Prometheus |
| **Tracing** | OpenTelemetry |
| **Authentication** | JWT-based Token System |

---

## 🚀 **Getting Started**  

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/YOUR_GITHUB_USERNAME/GraphTalk.git
cd GraphTalk
```

### **2️⃣ Install Dependencies**
```sh
bundle install
```

### **3️⃣ Set Up the Database**
```sh
rails db:create db:migrate
```

### **4️⃣ Start Redis**
```sh
redis-server
```

### **5️⃣ Start RabbitMQ**
```sh
brew services start rabbitmq  # Mac
sudo systemctl start rabbitmq-server  # Ubuntu/Debian
```

### **6️⃣ Start Prometheus**
```sh
prometheus --config.file=/etc/prometheus/prometheus.yml
```

### **7️⃣ Start Grafana**
```sh
brew services start grafana  # Mac
sudo systemctl start grafana  # Ubuntu/Debian
```
- **Access Grafana at**: `http://localhost:3000` (Default user: `admin`, Password: `admin`)

### **8️⃣ Start OpenTelemetry Collector**
```sh
docker run --rm -p 4317:4317 -p 4318:4318 otel/opentelemetry-collector-contrib
```

### **9️⃣ Start the Rails Server**
```sh
rails server
```
✅ The API will be running at `http://localhost:3000/graphql`

---

## 🔍 **GraphQL API Endpoints**
### **Queries**
#### 🏡 Fetch All Communities
```graphql
query {
  communities {
    id
    name
    description
  }
}
```

#### 📖 Fetch Discussions in a Community
```graphql
query {
  community(id: 1) {
    name
    discussions {
      id
      title
      content
    }
  }
}
```

### **Mutations**
#### 🛠 Register a User
```graphql
mutation {
  registerUser(username: "JohnDoe", email: "john@example.com", password: "password123") {
    user {
      id
      username
    }
    token
  }
}
```

#### 🔑 Login a User
```graphql
mutation {
  loginUser(email: "john@example.com", password: "password123") {
    user {
      id
      username
    }
    token
  }
}
```

#### 🌍 Create a Community (Admin Only)
```graphql
mutation {
  createCommunity(name: "Tech Enthusiasts", description: "Discuss tech trends") {
    community {
      id
      name
    }
  }
}
```

#### 📝 Create a Discussion
```graphql
mutation {
  createDiscussion(title: "Best programming language?", content: "Let's discuss!", communityId: 1) {
    discussion {
      id
      title
    }
  }
}
```

#### 💬 Add a Comment to a Discussion
```graphql
mutation {
  createComment(content: "Great discussion!", discussionId: 1) {
    comment {
      id
      content
    }
  }
}
```

#### 🚨 Delete a Comment (Moderator/Admin Only)
```graphql
mutation {
  deleteComment(commentId: 5) {
    success
  }
}
```

#### 🔄 Refresh Token
```graphql
mutation {
  refreshToken(refreshToken: "your_refresh_token") {
    token
  }
}
```

---

## 📊 **Monitoring & Observability**
### **Prometheus Metrics**
- **Total Requests** (`http_requests_total`)
- **Requests per Status Code** (`http_requests_total{status="200"}`)
- **Database Query Performance**

Access Prometheus Metrics at:
```
http://localhost:9394/metrics
```

### **Grafana Dashboards**
1. **Go to Grafana** → Add **Prometheus** as a data source (`http://localhost:9090`).
2. **Import Dashboard Panels**:
   - **Total API Requests**
   - **Requests per Status Code**
   - **Database Latency**

### **Distributed Tracing with OpenTelemetry**
- OpenTelemetry captures:
   - **GraphQL Query Execution**
   - **Database Query Performance**
   - **Redis Cache Hits & Misses**

To view traces:
- Open **Grafana → Explore**.
- Add **OTLP (OpenTelemetry) as a data source** (`http://localhost:4318`).
- View API request timelines & bottlenecks.

---

## 🔥 **Next Steps**
✅ **Deploy to Azure, AWS, or Railway.app**  
✅ **WebSockets for Real-time Discussions**  
✅ **Push Notifications & Email Alerts**

---

## 🎯 **Contributing**
1. Fork the repo
2. Create a new branch
3. Submit a pull request 🚀

---

## 🛡 **License**
This project is licensed under the **MIT License**.

---

## 📩 **Contact**
For questions or contributions, reach out via **GitHub Issues**.

---
