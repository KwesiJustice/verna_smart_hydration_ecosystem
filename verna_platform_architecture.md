# Verna Production Architecture

## Product scope

The platform should support:

- premium marketing pages
- direct e-commerce ordering
- subscriptions and scheduled delivery
- corporate quote capture and account management
- customer dashboards
- admin and logistics operations
- loyalty and sustainability programs
- support tickets and notifications

## Recommended stack

### Frontend

- Next.js App Router
- React + TypeScript
- Tailwind CSS
- Server Components for catalog and SEO-heavy pages
- Client Components for cart, checkout, dashboard widgets, and live delivery tracking

### Backend

- NestJS API
- PostgreSQL
- Redis for carts, sessions, queue coordination, and live order state
- Background workers for notifications, delivery events, loyalty updates, and subscription renewals

### Infrastructure

- Vercel for the frontend
- Render, Railway, Fly.io, or AWS ECS for NestJS services
- Managed PostgreSQL
- Managed Redis
- Object storage for marketing assets and customer documents

## Application surface

### Public routes

- `/`
- `/about`
- `/products`
- `/corporate-orders`
- `/bulk-delivery-services`
- `/sustainability`
- `/faqs`
- `/contact`
- `/delivery-areas`

### Authenticated customer routes

- `/dashboard`
- `/dashboard/orders`
- `/dashboard/subscriptions`
- `/dashboard/addresses`
- `/dashboard/rewards`
- `/dashboard/support`

### Corporate routes

- `/corporate/dashboard`
- `/corporate/quotes`
- `/corporate/deliveries`
- `/corporate/invoices`
- `/corporate/branches`

### Admin routes

- `/admin`
- `/admin/orders`
- `/admin/deliveries`
- `/admin/customers`
- `/admin/products`
- `/admin/pricing`
- `/admin/analytics`
- `/admin/support`

## Service modules

### Auth service

- customer, corporate, admin, and support roles
- email/password login
- OTP or SMS verification option
- session tokens or JWT plus refresh-token rotation

### Catalog service

- products
- pack sizes
- channel-based pricing
- availability status
- merchandising flags

### Cart and checkout service

- cart persistence for guest and signed-in users
- free-delivery rules
- checkout validation
- order creation
- payment intent creation

### Payments service

- MTN MoMo
- Vodafone Cash
- AirtelTigo Money
- Visa / Mastercard
- webhook reconciliation
- refund support

### Orders service

- order placement
- order status history
- reorder shortcuts
- invoice generation
- customer-facing summaries

### Delivery orchestration service

- dispatch scheduling
- route assignment
- driver status updates
- ETA recalculation
- delivery events
- SLA monitoring

### Subscriptions service

- weekly, bi-weekly, monthly frequencies
- pause, resume, skip, cancel
- next-run preview
- autopay preferences

### Corporate accounts service

- organizations
- branches
- quote management
- invoice terms
- account managers

### Loyalty and sustainability service

- points accrual
- rewards redemptions
- bottle return credits
- sustainability metrics

### Support service

- support tickets
- channel tagging
- order-linked conversations
- escalation rules

### Notifications service

- email events
- SMS events
- WhatsApp-ready integration point
- delivery updates
- payment confirmations
- subscription reminders

## Key business rules

- free delivery should be represented as a configurable rule rather than hard-coded copy
- corporate buyers may have negotiated pricing or invoice terms
- subscriptions should create future delivery jobs, not immediate orders only
- every order change should append a status event for traceability
- support tickets should be linkable to users, orders, subscriptions, and corporate accounts

## Performance and security

- route-level caching for public catalog and editorial sections
- image optimization for bottle photography and campaign assets
- field-level validation on checkout and quote forms
- payment webhooks verified by signature
- hashed passwords only
- audit logs for admin changes to price, order status, and delivery data
- rate limiting on auth, checkout, and support endpoints

## Deployment topology

### Frontend

- Vercel project for Next.js app
- environment variables for API base URL, analytics keys, payment public keys

### Backend

- NestJS API service
- worker service for jobs and event processing
- Redis-backed queue

### Data

- PostgreSQL with daily backups
- read replica if reporting traffic grows
- Redis with eviction policy tuned for cart/session storage

## Release plan

### Phase 1

- public storefront
- product catalog
- cart
- checkout
- direct order tracking
- support contact flows

### Phase 2

- customer dashboard
- subscription engine
- loyalty wallet
- delivery event streaming

### Phase 3

- corporate portal
- invoice workflows
- admin analytics
- sustainability reporting

## Recommended next engineering step

Convert the single HTML experience into a Next.js app with route groups for marketing, customer dashboard, corporate dashboard, and admin. Back it with the API and schema defined in the companion files.
