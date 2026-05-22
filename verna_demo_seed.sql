INSERT INTO products (sku, slug, name, pack_size_label, bottles_per_pack, pack_price_ghs, description, image_url)
VALUES
  ('VERNA-750-16', 'verna-750ml', 'Verna 750ml', '750ml', 16, 22.00, 'Premium hospitality-ready mineral water pack for executive tables and elevated refreshment.', 'product_images/WhatsApp Image 2026-05-20 at 08.24.50.jpeg'),
  ('VERNA-500-16', 'verna-500ml', 'Verna 500ml', '500ml', 16, 20.00, 'Everyday mineral water pack for homes, offices, and repeat replenishment.', 'product_images/WhatsApp Image 2026-05-20 at 08.24.52.jpeg'),
  ('VERNA-330-16', 'verna-330ml', 'Verna 330ml', '330ml', 16, 16.00, 'Compact event-friendly pack for schools, hospitality, and bulk gatherings.', 'product_images/WhatsApp Image 2026-05-20 at 08.24.53.jpeg')
ON CONFLICT (sku) DO NOTHING;

INSERT INTO app_users (id, role, full_name, email, phone, password_hash, loyalty_points)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'customer', 'Ama Asare', 'ama.asare@example.com', '+233506978103', 'demo-hash', 2840),
  ('22222222-2222-2222-2222-222222222222', 'corporate_user', 'Kwame Boadi', 'kwame.boadi@example.com', '+233241112223', 'demo-hash', 0),
  ('33333333-3333-3333-3333-333333333333', 'admin', 'Verna Admin', 'admin@verna.example', '+233201112223', 'demo-hash', 0)
ON CONFLICT (email) DO NOTHING;

INSERT INTO corporate_accounts (id, name, industry, support_phone, billing_email, credit_terms_days)
VALUES
  ('44444444-4444-4444-4444-444444444444', 'Ghana Hotels Group', 'Hospitality', '+233506978103', 'ap@ghanahotels.example', 30)
ON CONFLICT DO NOTHING;

INSERT INTO corporate_memberships (corporate_account_id, user_id, title, is_primary)
VALUES
  ('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Facilities Lead', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO addresses (id, user_id, label, recipient_name, recipient_phone, address_line_1, city, region, landmark, is_default)
VALUES
  ('55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 'Home', 'Ama Asare', '+233506978103', '12 East Legon Lane', 'Accra', 'Greater Accra', 'Near A&C Mall', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO addresses (id, corporate_account_id, label, recipient_name, recipient_phone, address_line_1, city, region, landmark, is_default)
VALUES
  ('66666666-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', 'Airport City Office', 'Kwame Boadi', '+233241112223', 'Plot 8 Independence Avenue', 'Accra', 'Greater Accra', 'Airport City block C', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO orders (id, order_number, user_id, delivery_address_id, status, subtotal_ghs, delivery_fee_ghs, total_ghs, payment_method, delivery_date, delivery_window, notes)
VALUES
  ('77777777-7777-7777-7777-777777777777', 'VF-2847', '11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 'out_for_delivery', 40.00, 0.00, 40.00, 'mtn_momo', CURRENT_DATE, '10:00 AM - 1:00 PM', 'Leave at reception if unavailable')
ON CONFLICT (order_number) DO NOTHING;

INSERT INTO order_items (order_id, product_id, product_name_snapshot, unit_price_ghs, quantity, line_total_ghs)
SELECT '77777777-7777-7777-7777-777777777777', id, name, pack_price_ghs, 2, pack_price_ghs * 2
FROM products
WHERE sku = 'VERNA-500-16'
ON CONFLICT DO NOTHING;

INSERT INTO payments (order_id, provider_reference, method, status, amount_ghs, paid_at)
VALUES
  ('77777777-7777-7777-7777-777777777777', 'MOMO-REF-2847', 'mtn_momo', 'paid', 40.00, NOW())
ON CONFLICT DO NOTHING;

INSERT INTO deliveries (id, order_id, status, driver_name, driver_phone, vehicle_label, eta_at)
VALUES
  ('88888888-8888-8888-8888-888888888888', '77777777-7777-7777-7777-777777777777', 'en_route', 'Kofi Mensah', '+233245556667', 'Van 04', NOW() + INTERVAL '35 minutes')
ON CONFLICT DO NOTHING;

INSERT INTO delivery_events (delivery_id, event_type, event_note, event_time)
VALUES
  ('88888888-8888-8888-8888-888888888888', 'order_confirmed', 'Customer order confirmed', NOW() - INTERVAL '70 minutes'),
  ('88888888-8888-8888-8888-888888888888', 'packed', 'Packed at Verna dispatch', NOW() - INTERVAL '40 minutes'),
  ('88888888-8888-8888-8888-888888888888', 'out_for_delivery', 'Driver departed warehouse', NOW() - INTERVAL '12 minutes')
ON CONFLICT DO NOTHING;

INSERT INTO subscriptions (id, user_id, address_id, status, frequency, next_run_date, payment_method)
VALUES
  ('99999999-9999-9999-9999-999999999999', '11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 'active', 'WEEKLY', CURRENT_DATE + 7, 'visa')
ON CONFLICT DO NOTHING;

INSERT INTO subscription_items (subscription_id, product_id, quantity)
SELECT '99999999-9999-9999-9999-999999999999', id, 3
FROM products
WHERE sku = 'VERNA-500-16'
ON CONFLICT DO NOTHING;

INSERT INTO loyalty_transactions (user_id, source_type, source_id, points_delta, description)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'order', '77777777-7777-7777-7777-777777777777', 40, 'Order reward for VF-2847'),
  ('11111111-1111-1111-1111-111111111111', 'recycling', NULL, 20, 'Bottle return bonus')
ON CONFLICT DO NOTHING;

INSERT INTO support_tickets (id, ticket_number, user_id, order_id, subject, channel, status, priority)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'SUP-1001', '11111111-1111-1111-1111-111111111111', '77777777-7777-7777-7777-777777777777', 'Please call before arrival', 'web', 'open', 'normal')
ON CONFLICT (ticket_number) DO NOTHING;

INSERT INTO support_messages (ticket_id, author_user_id, body)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Please call before arrival because the gate can be locked.'),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 'Noted. Driver instructions have been updated.')
ON CONFLICT DO NOTHING;
