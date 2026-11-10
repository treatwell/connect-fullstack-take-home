import type { TransactionListResponse, TransactionType } from '../types/transaction';

const BASE_URL = '/api';

type FetchTransactionsParams = {
  supplierId: number;
  type?: TransactionType;
  toDate?: string;
  signal?: AbortSignal;
};

export async function fetchTransactions({
  supplierId,
  type,
  toDate,
  signal,
}: FetchTransactionsParams): Promise<TransactionListResponse> {
  const params = new URLSearchParams();

  if (type) params.set('type', type);
  if (toDate) params.set('toDate', toDate);

  const url = `${BASE_URL}/suppliers/${supplierId}/transactions?${params.toString()}`;
  const response = await fetch(url, { signal } as RequestInit);

  if (!response.ok) {
    throw new Error(`Failed to fetch transactions: ${response.status}`);
  }

  return response.json();
}
