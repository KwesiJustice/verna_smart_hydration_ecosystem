# Verna Digital Commerce Build

This workspace now contains a real two-app implementation path for Verna Natural Mineral Water:

- `verna-frontend`
  Next.js App Router storefront migrated from the original HTML prototype
- `verna-backend`
  NestJS API for products, auth, addresses, orders, payments, support, and corporate intake

The original prototype and planning artifacts are still included so the design language and technical blueprint remain visible during implementation.

## Workspace structure

- `verna-frontend`
  Production-oriented frontend with:
  - componentized storefront UI
  - product data loading from the backend with fallback support
  - cart and checkout experience
  - sign-in and registration flows
  - corporate quote submission
  - support request submission
- `verna-backend`
  NestJS API scaffold with:
  - JWT auth
  - product catalog
  - address management
  - order creation
  - corporate lead intake
  - support request intake
- `verna_smart_hydration_ecosystem.html`
  Original single-file storefront prototype kept for reference
- `verna_platform_architecture.md`
  Proposed production architecture and deployment topology
- `verna_api_contract.md`
  API blueprint for storefront, checkout, subscriptions, logistics, and admin operations
- `verna_database_schema.sql`
  PostgreSQL schema planning reference
- `verna_demo_seed.sql`
  Demo content and sample data reference

## Local development

Frontend:

```bash
npm run dev:frontend
```

Backend:

```bash
npm run dev:backend
```

Build both:

```bash
npm run build
```

Default local ports:

- Frontend: `http://localhost:3000`
- Backend: `http://localhost:4000`

## Environment

- Frontend env example: `verna-frontend/.env.local.example`
- Backend env example: `verna-backend/.env.example`

## Current status

- The storefront is now a real Next.js app instead of only a static HTML file
- Product loading, auth, checkout, quote, and support flows are wired for backend integration
- Backend order creation now calculates pricing from server-side product data instead of trusting client totals
- Admin-only guards were added to product management routes

## Remaining production work

- Payment provider credentialing and webhook verification
- Delivery orchestration and live tracking events
- Expanded admin/support workflows
- End-to-end QA against a real PostgreSQL environment
# verna_smart_hydration_ecosystem
