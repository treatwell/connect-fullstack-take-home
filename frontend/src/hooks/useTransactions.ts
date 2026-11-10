import { useQuery } from '@tanstack/react-query';
import { fetchTransactions } from '../api/transactions';
import type { TransactionFilter, TransactionType, TransactionListResponse } from '../types/transaction';

const filterToType: Record<TransactionFilter, TransactionType | undefined> = {
  all: undefined,
  sales: 'ORDER',
  balance_payments: 'PAYIN',
  payouts: 'PAYOUT',
  other: 'OTHER',
};

export function useTransactions(supplierId: number, filter: TransactionFilter) {
  const type = filterToType[filter];

  return useQuery<TransactionListResponse>({
    queryKey: ['transactions', supplierId, filter],
    queryFn: ({ signal }) =>
      fetchTransactions({ supplierId, type, signal }),
    refetchOnWindowFocus: false,
  });
}
