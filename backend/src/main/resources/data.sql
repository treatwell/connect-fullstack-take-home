-- Seed data: 33 transactions for supplierId = 1001
-- IDs are chronologically ordered (oldest = smallest)
-- Business rules:
--   • Salon pays a monthly SaaS fee (OTHER, negative)
--   • Daily appointments: new customers (newCustomer=TRUE) pay 15% commission,
--     returning customers pay none
--   • Every week TW emits a payout for the full balance owed to the salon
--   • Payout amounts never exceed the balance
--   • Cancellations/refunds reverse the original order (negative amounts)

INSERT INTO transactions (id, transaction_type, supplier_id, source_id, reference_type, reference_id, reference, description, status, currency, amount, net_amount, fee_amount, tax_amount, payment_method, fulfilment_date, pay_at_venue, new_customer) VALUES

-- ═══════════════════════════════════════════════════════════════
-- WEEK 1  (Day -28 → Day -22)
-- ═══════════════════════════════════════════════════════════════

-- Day -28  |  new customer, 15% commission → +153.00 → balance: 153.00
('a1b2c3d4-0001-4000-8000-000000000001', 'ORDER', 1001, '1', 'ORDER_ID', '10001', 'ORD-10001', 'Spa Day Package', 'COMPLETED', 'EUR', 180.00, 153.00, 27.00, 0.00, 'CARD', CURRENT_DATE - 28, FALSE, TRUE),

-- Day -27  |  new customer, 15% commission → +68.00 → balance: 221.00
('a1b2c3d4-0001-4000-8000-000000000002', 'ORDER', 1001, '2', 'ORDER_ID', '10002', 'ORD-10002', 'Hair Straightening', 'COMPLETED', 'EUR', 80.00, 68.00, 12.00, 0.00, 'CARD', CURRENT_DATE - 27, FALSE, TRUE),

-- Day -26  |  returning, no commission → +45.00 → balance: 266.00
('a1b2c3d4-0001-4000-8000-000000000003', 'ORDER', 1001, '3', 'ORDER_ID', '10003', 'ORD-10003', 'Swedish Massage - 30min', 'COMPLETED', 'EUR', 45.00, 45.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 26, FALSE, FALSE),

-- Day -25  |  returning, no commission → +18.00 → balance: 284.00
('a1b2c3d4-0001-4000-8000-000000000004', 'ORDER', 1001, '4', 'ORDER_ID', '10004', 'ORD-10004', 'Childrens Haircut', 'COMPLETED', 'EUR', 18.00, 18.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 25, FALSE, FALSE),

-- Day -24  |  new customer, 15% commission → +170.00 → balance: 454.00
('a1b2c3d4-0001-4000-8000-000000000005', 'ORDER', 1001, '5', 'ORDER_ID', '10005', 'ORD-10005', 'Bridal Hair & Makeup', 'COMPLETED', 'EUR', 200.00, 170.00, 30.00, 0.00, 'CARD', CURRENT_DATE - 24, FALSE, TRUE),

-- Day -23  |  commission adjustment -15.00 → balance: 439.00
('a1b2c3d4-0001-4000-8000-000000000006', 'OTHER', 1001, '6', 'LEDGER_ENTRY_ID', 'LED-001', 'ADJ-001', 'Commission adjustment', 'COMPLETED', 'EUR', -15.00, -15.00, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 23, FALSE, FALSE),

-- Day -22  |  weekly payout zeros balance → balance: 0.00
('a1b2c3d4-0001-4000-8000-000000000007', 'PAYOUT', 1001, '7', 'REMITTANCE_PAYMENT_ID', 'REM-001', 'PAY-001', 'Weekly payout', 'PAID', 'EUR', 439.00, 439.00, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 22, FALSE, FALSE),

-- ═══════════════════════════════════════════════════════════════
-- WEEK 2  (Day -21 → Day -15)
-- SaaS fee pushes balance negative; orders recover it
-- ═══════════════════════════════════════════════════════════════

-- Day -21  |  monthly SaaS fee → -94.00 → balance: -94.00
('a1b2c3d4-0001-4000-8000-000000000008', 'OTHER', 1001, '8', 'LEDGER_ENTRY_ID', 'LED-002', 'SAAS-001', 'Monthly SaaS subscription fee', 'COMPLETED', 'EUR', -94.00, -94.00, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 21, FALSE, FALSE),

-- Day -20  |  returning → +50.00 → balance: -44.00
('a1b2c3d4-0001-4000-8000-000000000009', 'ORDER', 1001, '9', 'ORDER_ID', '10006', 'ORD-10006', 'Scalp Treatment', 'COMPLETED', 'EUR', 50.00, 50.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 20, FALSE, FALSE),

-- Day -19  |  returning → +55.00 → balance: 11.00
('a1b2c3d4-0001-4000-8000-000000000010', 'ORDER', 1001, '10', 'ORDER_ID', '10007', 'ORD-10007', 'Gel Nails - Full Set', 'COMPLETED', 'EUR', 55.00, 55.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 19, FALSE, FALSE),

-- Day -18  |  new customer, 15% commission → +110.50 → balance: 121.50
('a1b2c3d4-0001-4000-8000-000000000011', 'ORDER', 1001, '11', 'ORDER_ID', '10008', 'ORD-10008', 'Keratin Smoothing', 'COMPLETED', 'EUR', 130.00, 110.50, 19.50, 0.00, 'CARD', CURRENT_DATE - 18, FALSE, TRUE),

-- Day -17  |  new customer, 15% commission → +63.75 → balance: 185.25
('a1b2c3d4-0001-4000-8000-000000000012', 'ORDER', 1001, '12', 'ORDER_ID', '10009', 'ORD-10009', 'Lash Extensions', 'COMPLETED', 'EUR', 75.00, 63.75, 11.25, 0.00, 'CARD', CURRENT_DATE - 17, FALSE, TRUE),

-- Day -16  |  returning +110.00, refund ORD-10006 -50.00 → net +60.00 → balance: 245.25
('a1b2c3d4-0001-4000-8000-000000000013', 'ORDER', 1001, '13', 'ORDER_ID', '10010', 'ORD-10010', 'Hot Stone Massage - 90min', 'COMPLETED', 'EUR', 110.00, 110.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 16, FALSE, FALSE),
('a1b2c3d4-0001-4000-8000-000000000014', 'ORDER', 1001, '14', 'ORDER_ID', '10006', 'ORD-10006', 'Scalp Treatment', 'REFUNDED', 'EUR', -50.00, -50.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 16, FALSE, FALSE),

-- Day -15  |  weekly payout zeros balance → balance: 0.00
('a1b2c3d4-0001-4000-8000-000000000015', 'PAYOUT', 1001, '15', 'REMITTANCE_PAYMENT_ID', 'REM-002', 'PAY-002', 'Weekly payout', 'PAID', 'EUR', 245.25, 245.25, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 15, FALSE, FALSE),

-- ═══════════════════════════════════════════════════════════════
-- WEEK 3  (Day -14 → Day -8)
-- Includes a cancellation and a failed payout followed by retry
-- ═══════════════════════════════════════════════════════════════

-- Day -14  |  new customer → +127.50 → balance: 127.50
('a1b2c3d4-0001-4000-8000-000000000016', 'ORDER', 1001, '16', 'ORDER_ID', '10011', 'ORD-10011', 'Balayage Treatment', 'COMPLETED', 'EUR', 150.00, 127.50, 22.50, 0.00, 'CARD', CURRENT_DATE - 14, FALSE, TRUE),

-- Day -13  |  returning → +20.00 → balance: 147.50
('a1b2c3d4-0001-4000-8000-000000000017', 'ORDER', 1001, '17', 'ORDER_ID', '10012', 'ORD-10012', 'Eyebrow Threading', 'COMPLETED', 'EUR', 20.00, 20.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 13, FALSE, FALSE),

-- Day -12  |  new +72.25, returning +45.00 → balance: 264.75
('a1b2c3d4-0001-4000-8000-000000000018', 'ORDER', 1001, '18', 'ORDER_ID', '10013', 'ORD-10013', 'Deep Tissue Massage - 60min', 'COMPLETED', 'EUR', 85.00, 72.25, 12.75, 0.00, 'CARD', CURRENT_DATE - 12, FALSE, TRUE),
('a1b2c3d4-0001-4000-8000-000000000019', 'ORDER', 1001, '19', 'ORDER_ID', '10014', 'ORD-10014', 'Pedicure & Nail Art', 'COMPLETED', 'EUR', 45.00, 45.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 12, FALSE, FALSE),

-- Day -11  |  new customer → +55.25 → balance: 320.00
('a1b2c3d4-0001-4000-8000-000000000020', 'ORDER', 1001, '20', 'ORDER_ID', '10015', 'ORD-10015', 'Mens Grooming Package', 'COMPLETED', 'EUR', 65.00, 55.25, 9.75, 0.00, 'CARD', CURRENT_DATE - 11, FALSE, TRUE),

-- Day -10  |  new customer → +59.50 → balance: 379.50
('a1b2c3d4-0001-4000-8000-000000000021', 'ORDER', 1001, '21', 'ORDER_ID', '10016', 'ORD-10016', 'Facial Treatment', 'COMPLETED', 'EUR', 70.00, 59.50, 10.50, 0.00, 'CARD', CURRENT_DATE - 10, FALSE, TRUE),

-- Day -9  |  cancel ORD-10013 -72.25, FAILED payout (no impact) → balance: 307.25
('a1b2c3d4-0001-4000-8000-000000000022', 'ORDER', 1001, '22', 'ORDER_ID', '10013', 'ORD-10013', 'Deep Tissue Massage - 60min', 'CANCELLED', 'EUR', -85.00, -72.25, -12.75, 0.00, 'CARD', CURRENT_DATE - 9, FALSE, TRUE),
('a1b2c3d4-0001-4000-8000-000000000023', 'PAYOUT', 1001, '23', 'REMITTANCE_PAYMENT_ID', 'REM-003', 'PAY-003', 'Weekly payout', 'FAILED', 'EUR', 307.25, 307.25, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 9, FALSE, FALSE),

-- Day -8  |  payout retry zeros balance → balance: 0.00
('a1b2c3d4-0001-4000-8000-000000000024', 'PAYOUT', 1001, '24', 'REMITTANCE_PAYMENT_ID', 'REM-004', 'PAY-004', 'Weekly payout (retry)', 'PAID', 'EUR', 307.25, 307.25, 0.00, 0.00, 'BANK_TRANSFER', CURRENT_DATE - 8, FALSE, FALSE),

-- ═══════════════════════════════════════════════════════════════
-- WEEK 4  (Day -7 → Day -1)  —  current week, no payout yet
-- ═══════════════════════════════════════════════════════════════

-- Day -7  |  returning → +95.00 → balance: 95.00
('a1b2c3d4-0001-4000-8000-000000000025', 'ORDER', 1001, '25', 'ORDER_ID', '10017', 'ORD-10017', 'Highlights & Blowdry', 'COMPLETED', 'EUR', 95.00, 95.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 7, FALSE, FALSE),

-- Day -6  |  new +102.00, returning +35.00 → balance: 232.00
('a1b2c3d4-0001-4000-8000-000000000026', 'ORDER', 1001, '26', 'ORDER_ID', '10018', 'ORD-10018', 'Full Color Treatment', 'COMPLETED', 'EUR', 120.00, 102.00, 18.00, 0.00, 'CARD', CURRENT_DATE - 6, FALSE, TRUE),
('a1b2c3d4-0001-4000-8000-000000000027', 'ORDER', 1001, '27', 'ORDER_ID', '10019', 'ORD-10019', 'Manicure', 'COMPLETED', 'EUR', 35.00, 35.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 6, FALSE, FALSE),

-- Day -5  |  new customer → +46.75 → balance: 278.75
('a1b2c3d4-0001-4000-8000-000000000028', 'ORDER', 1001, '28', 'ORDER_ID', '10020', 'ORD-10020', 'Haircut & Styling', 'COMPLETED', 'EUR', 55.00, 46.75, 8.25, 0.00, 'CARD', CURRENT_DATE - 5, FALSE, TRUE),

-- Day -4  |  returning → +25.00 → balance: 303.75
('a1b2c3d4-0001-4000-8000-000000000029', 'ORDER', 1001, '29', 'ORDER_ID', '10021', 'ORD-10021', 'Beard Trim', 'COMPLETED', 'EUR', 25.00, 25.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 4, FALSE, FALSE),

-- Day -3  |  returning → +30.00 → balance: 333.75
('a1b2c3d4-0001-4000-8000-000000000030', 'ORDER', 1001, '30', 'ORDER_ID', '10022', 'ORD-10022', 'Hair Wash & Cut', 'COMPLETED', 'EUR', 30.00, 30.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 3, FALSE, FALSE),

-- Day -2  |  new customer → +34.00 → balance: 367.75
('a1b2c3d4-0001-4000-8000-000000000031', 'ORDER', 1001, '31', 'ORDER_ID', '10023', 'ORD-10023', 'Waxing - Full Legs', 'COMPLETED', 'EUR', 40.00, 34.00, 6.00, 0.00, 'CARD', CURRENT_DATE - 2, FALSE, TRUE),

-- Day -1  |  returning → +28.00 → balance: 395.75
('a1b2c3d4-0001-4000-8000-000000000032', 'ORDER', 1001, '32', 'ORDER_ID', '10024', 'ORD-10024', 'Eyebrow Tinting', 'COMPLETED', 'EUR', 28.00, 28.00, 0.00, 0.00, 'CARD', CURRENT_DATE - 1, FALSE, FALSE);
