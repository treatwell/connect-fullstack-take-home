export type TransactionType = 'ORDER' | 'PAYIN' | 'PAYOUT' | 'OTHER';

export type TransactionStatus =
  | 'COMPLETED'
  | 'CANCELLED'
  | 'FAILED'
  | 'PAID'
  | 'RECEIVED'
  | 'REFUNDED'
  | 'REVERSED';

export type TransactionEntry = {
  id: string;
  type: TransactionType;
  referenceId: string;
  reference?: string;
  description: string;
  amount: number;
  netAmount: number;
  feeAmount: number;
  status: TransactionStatus;
  paymentMethod?: string;
  fulfilmentDate: string;
  newCustomer?: boolean;
};

export type TransactionListResponse = {
  transactions: TransactionEntry[];
};

export type TransactionFilter = 'all' | 'sales' | 'balance_payments' | 'payouts' | 'other';
