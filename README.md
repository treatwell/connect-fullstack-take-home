# Transaction Aggregator + Balance Overview

This repository is mirrored from Treatwell's internal GitLab.
Changes made on GitHub are overwritten by the next mirror update.

A simplified monorepo containing a Spring Boot backend and React frontend for managing and displaying supplier transactions.

## Project Structure

```
interview-challenge/
├── backend/          # Spring Boot 3, Java 21, H2 in-memory DB
└── frontend/         # React 18, TypeScript, Vite, TanStack Query
```

## Prerequisites

- **Java 21** (or later)
- **Maven 3.9+**
- **Node.js 18+** and **npm 9+**

## Getting Started

### Backend

```bash
cd backend
./mvnw spring-boot:run
# Or if you have Maven installed:
mvn spring-boot:run
```

The API starts at `http://localhost:8080`. The H2 console is available at `http://localhost:8080/h2-console` (JDBC URL: `jdbc:h2:mem:transactions`).

### Frontend

```bash
cd frontend
npm install
npm run dev
```

The app starts at `http://localhost:5173`. API requests are proxied to the backend.

## API Endpoints

### List Transactions

```
GET /api/suppliers/{supplierId}/transactions
```

Query parameters:

| Parameter  | Type                                | Description                |
|------------|-------------------------------------|----------------------------|
| `type`     | `ORDER\|PAYIN\|PAYOUT\|OTHER`       | Filter by transaction type |
| `status`   | `COMPLETED\|CANCELLED\|FAILED\|...` | Filter by status           |
| `fromDate` | `YYYY-MM-DD`                        | Start date filter          |
| `toDate`   | `YYYY-MM-DD`                        | End date filter            |

Example:
```bash
curl http://localhost:8080/api/suppliers/1001/transactions
curl http://localhost:8080/api/suppliers/1001/transactions?type=ORDER
```

### Webhook (Upsert Transaction)

```
POST /api/webhooks/transactions
```

Accepts a JSON body to create or update a transaction.

Example:
```bash
curl -X POST http://localhost:8080/api/webhooks/transactions \
  -H 'Content-Type: application/json' \
  -d '{
    "transactionType": "ORDER",
    "supplierId": 1001,
    "sourceId": "1",
    "referenceId": "99999",
    "reference": "ORD-99999",
    "description": "Test Booking",
    "status": "COMPLETED",
    "currency": "EUR",
    "amount": 42.00,
    "netAmount": 35.70,
    "feeAmount": 6.30,
    "taxAmount": 0.00,
    "paymentMethod": "CARD",
    "fulfilmentDate": "2024-03-20",
    "payAtVenue": false,
    "newCustomer": true
  }'
```

## Seed Data

The backend comes pre-loaded with ~30 transactions for `supplierId = 1001`, including a mix of orders, payins, payouts, and other transaction types spread across the last 30 days.

---

## The Challenge

This is a take-home coding exercise. There are **four tasks** to complete.

---

### Task 1 — Paginated Transaction Loading

The transaction list currently returns **all** results in a single response. This won't scale.

**Requirements**

- The backend must return at most **10 transactions per response**.
- The client must be able to request additional transactions beyond the first 10.
- The solution must work with the existing filters and ordering.
- The frontend must let the user access the full result set.

**Choose the approach you think fits best and be ready to explain your reasoning in the follow-up interview.**

---

### Task 2 — Find and Fix the Bug

There is a **logical bug** in the codebase. It was introduced deliberately and is related to how the webhook upsert works.

**Clues**

- A `sourceId` is scoped to the originating system for a given transaction type (e.g., an order management system issues ORDER source IDs; a remittance system issues PAYOUT source IDs).

---

### Task 3 — Tests
The codebase has no tests. Add tests where you think they add the most value.

**Guidance**

- Focus on the areas most likely to break — think about the service layer, the webhook upsert logic, and how filters interact with pagination.
- We care more about what you chose to test and why than raw coverage numbers.
- You're free to test at whatever level you think is appropriate (unit, integration, or both).
- Be ready to discuss your testing strategy and any trade-offs you made in the follow-up interview.


---

### Task 4 — UX & Accessibility Audit

The frontend has a number of UX and accessibility issues. There is no explicit list — part of the task is identifying them yourself.

Review the app with fresh eyes, as a user and as an engineer. Consider how it behaves across different interaction modes, and how it communicates state to users.

Fix what you find. Be prepared to walk through your findings and reasoning in the follow-up technical interview.

---

## AI Usage

Usage of AI tools is fine. If you use AI, we are interested in how you collaborated with it:
the prompts or chat history, where it influenced your design, implementation, or debugging
decisions, and where you chose to accept, reject, or adapt its suggestions.

We will challenge you on the decisions you made during the follow-up conversation. If you
offload the entire exercise to AI and do not understand the approaches taken, you may struggle to answer our questions.

---

## Evaluation Criteria

| Area            | What we look at                                                                        |
|-----------------|----------------------------------------------------------------------------------------|
| Correctness     | Does pagination work end-to-end? Is the bug properly identified and fixed?             |
| Code quality    | Clean, idiomatic Java/TypeScript; no unnecessary abstractions                          |
| UX              | Smooth pagination; sensible loading and empty states; usable interface                 |
| Accessibility   | Correct semantic HTML; keyboard navigability; screen reader compatibility              |
| Communication   | Clear explanation of the bug, UX issues found, and the reasoning behind each fix       |

---

## Tech Stack

### Backend
- Java 21
- Spring Boot 3.3
- Spring Data JPA
- H2 (in-memory database)

### Frontend
- React 18
- TypeScript
- Vite
- TanStack Query v5 (React Query)
- CSS Modules
