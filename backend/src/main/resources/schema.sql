CREATE TABLE transactions (
    id              VARCHAR(36)    PRIMARY KEY,
    transaction_type VARCHAR(20)   NOT NULL,
    supplier_id     BIGINT         NOT NULL,
    source_id       VARCHAR(255),
    reference_type  VARCHAR(30),
    reference_id    VARCHAR(255),
    reference       VARCHAR(255),
    description     VARCHAR(500),
    status          VARCHAR(20)    NOT NULL,
    currency        VARCHAR(3),
    amount          DECIMAL(12,2),
    net_amount      DECIMAL(12,2),
    fee_amount      DECIMAL(12,2),
    tax_amount      DECIMAL(12,2),
    payment_method  VARCHAR(50),
    fulfilment_date DATE,
    pay_at_venue    BOOLEAN        DEFAULT FALSE,
    new_customer    BOOLEAN        DEFAULT FALSE,
    created         TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated         TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_transactions_supplier ON transactions(supplier_id);
CREATE INDEX idx_transactions_fulfilment ON transactions(fulfilment_date DESC, id DESC);
