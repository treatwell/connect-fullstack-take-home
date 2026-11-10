import type { TransactionEntry, TransactionFilter } from '../../types/transaction';

export type BalanceFilterItem = {
  label: string;
  value: TransactionFilter;
};

export function getBalanceFilterItems(): BalanceFilterItem[] {
  return [
    { label: 'All', value: 'all' },
    { label: 'Sales', value: 'sales' },
    { label: 'Balance Payments', value: 'balance_payments' },
    { label: 'Payouts', value: 'payouts' },
    { label: 'Other', value: 'other' },
  ];
}

export function groupTransactionsByDate(
  transactions: TransactionEntry[],
): Map<string, TransactionEntry[]> {
  const groups = new Map<string, TransactionEntry[]>();

  for (const tx of transactions) {
    const date = tx.fulfilmentDate;
    const existing = groups.get(date);
    if (existing) {
      existing.push(tx);
    } else {
      groups.set(date, [tx]);
    }
  }

  return groups;
}

function balanceImpact(tx: TransactionEntry): number {
  // Failed payouts never went through — no balance impact
  if (tx.type === 'PAYOUT' && tx.status === 'FAILED') return 0;
  // Payouts and paid invoices are money leaving the account
  if (tx.type === 'PAYOUT' || tx.type === 'PAYIN') return -tx.netAmount;
  return tx.netAmount;
}

export function getDateGroupTotal(transactions: TransactionEntry[]): number {
  return transactions.reduce((sum, tx) => sum + balanceImpact(tx), 0);
}

export function computeClosingBalances(
  grouped: Map<string, TransactionEntry[]>,
): Map<string, number> {
  const dates = Array.from(grouped.keys());
  // dates are newest-first; reverse to accumulate from oldest
  const oldestFirst = [...dates].reverse();
  const balances = new Map<string, number>();
  let running = 0;
  for (const date of oldestFirst) {
    const dayNet = getDateGroupTotal(grouped.get(date)!);
    running += dayNet;
    balances.set(date, running);
  }
  return balances;
}

export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat('en-IE', {
    style: 'currency',
    currency: 'EUR',
  }).format(amount);
}

export function formatDate(dateString: string): string {
  const date = new Date(dateString + 'T00:00:00');
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);

  if (date.getTime() === today.getTime()) return 'Today';
  if (date.getTime() === yesterday.getTime()) return 'Yesterday';

  return date.toLocaleDateString('en-GB', {
    weekday: 'short',
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  });
}
