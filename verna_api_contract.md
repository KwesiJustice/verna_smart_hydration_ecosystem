# Verna API Contract Blueprint

## Auth

### `POST /api/v1/auth/register`

Creates a customer account.

Request:

```json
{
  "fullName": "Esi Owusu",
  "email": "esi@example.com",
  "phone": "+233506978103",
  "password": "secure-password"
}
```

### `POST /api/v1/auth/login`

Authenticates a user and returns access and refresh tokens.

### `POST /api/v1/auth/logout`

Revokes the active session.

### `GET /api/v1/auth/me`

Returns profile, role, loyalty balance, and default address.

## Catalog

### `GET /api/v1/products`

Returns active products, pack metadata, pricing, delivery badges, and merchandising copy.

### `PATCH /api/v1/admin/products/:productId`

Admin-only update for name, price, status, image, badges, and channel availability.

## Cart

### `GET /api/v1/cart`

Returns current cart contents for guest session or signed-in customer.

### `POST /api/v1/cart/items`

Adds an item to cart.

```json
{
  "productId": "750ml-pack",
  "quantity": 2
}
```

### `PATCH /api/v1/cart/items/:itemId`

Updates quantity.

### `DELETE /api/v1/cart/items/:itemId`

Removes a cart item.

## Checkout and payments

### `POST /api/v1/checkout/validate`

Validates address, slot, stock, delivery rule, and payment availability.

### `POST /api/v1/checkout/orders`

Creates order and payment intent.

```json
{
  "customerId": "uuid",
  "deliveryAddressId": "uuid",
  "deliveryDate": "2026-05-21",
  "deliveryWindow": "10:00 AM - 1:00 PM",
  "paymentMethod": "MTN_MOMO",
  "notes": "Reception desk drop-off"
}
```

### `POST /api/v1/payments/webhooks/momo`

Payment reconciliation endpoint for mobile money providers.

### `POST /api/v1/payments/webhooks/cards`

Card payment webhook receiver.

## Orders

### `GET /api/v1/orders`

Returns customer order history with order items, total, and latest status.

### `GET /api/v1/orders/:orderId`

Returns detail view including payment, address, delivery, status history, and support links.

### `POST /api/v1/orders/:orderId/reorder`

Creates a new cart from a previous order.

## Delivery tracking

### `GET /api/v1/orders/:orderId/tracking`

Returns delivery timeline, dispatch status, ETA, and driver summary.

### `POST /api/v1/admin/deliveries/:deliveryId/events`

Adds a delivery event like `packed`, `driver_assigned`, `out_for_delivery`, or `delivered`.

## Subscriptions

### `GET /api/v1/subscriptions`

Returns active subscriptions, next run date, and delivery rules.

### `POST /api/v1/subscriptions`

Creates recurring delivery plan.

```json
{
  "productId": "500ml-pack",
  "quantity": 3,
  "frequency": "WEEKLY",
  "deliveryAddressId": "uuid",
  "paymentMethod": "VISA",
  "startDate": "2026-05-24"
}
```

### `PATCH /api/v1/subscriptions/:subscriptionId`

Pause, resume, skip, adjust quantity, or update payment method.

## Addresses

### `GET /api/v1/addresses`

Returns saved addresses.

### `POST /api/v1/addresses`

Creates new address record.

## Corporate and bulk ordering

### `POST /api/v1/corporate/quotes`

Captures quote request from office, hotel, school, hospital, church, or event buyer.

### `GET /api/v1/corporate/quotes`

Lists quotes for the signed-in corporate account.

### `POST /api/v1/corporate/orders`

Creates a corporate order with branch, invoice settings, and requested delivery date.

## Loyalty and sustainability

### `GET /api/v1/loyalty`

Returns points balance, tier, rewards, and recent transactions.

### `POST /api/v1/loyalty/redeem`

Redeems a reward against the customer wallet.

### `POST /api/v1/sustainability/returns`

Logs bottle return event and awards points or credits.

## Support

### `POST /api/v1/support/tickets`

Creates a support ticket from contact form, dashboard, or checkout.

### `GET /api/v1/support/tickets`

Lists tickets for customer, corporate user, or support/admin role.

### `POST /api/v1/support/tickets/:ticketId/messages`

Adds follow-up message.

## Admin analytics

### `GET /api/v1/admin/analytics/overview`

Returns revenue, active deliveries, order volume, customer growth, and support totals.

### `GET /api/v1/admin/pricing`

Returns current product pricing and promotional rules.

### `PATCH /api/v1/admin/pricing/:productId`

Updates pricing with audit logging.
