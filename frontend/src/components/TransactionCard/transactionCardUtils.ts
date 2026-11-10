import type { TransactionType, TransactionStatus } from '../../types/transaction';

type TransactionDisplay = {
  icon: string;
  label: string;
};

export function getTransactionDisplay(
  type: TransactionType,
  status: TransactionStatus,
): TransactionDisplay {
  if (status === 'CANCELLED') {
    return { icon: '\u2715', label: 'Cancellation' };
  }
  if (status === 'REFUNDED') {
    return { icon: '\u21A9', label: 'Refund' };
  }

  switch (type) {
    case 'ORDER':
      return { icon: '\uD83D\uDC87', label: 'Appointment' };
    case 'PAYOUT':
      return { icon: '\u2713', label: 'Payout' };
    case 'PAYIN':
      return { icon: '\uD83D\uDCCB', label: 'Paid invoice' };
    case 'OTHER':
      return { icon: '\u2022', label: 'Other' };
  }
}

export function getStatusLabel(status: TransactionStatus): string {
  const labels: Record<TransactionStatus, string> = {
    COMPLETED: 'Completed',
    CANCELLED: 'Cancelled',
    FAILED: 'Failed',
    PAID: 'Paid',
    RECEIVED: 'Received',
    REFUNDED: 'Refunded',
    REVERSED: 'Reversed',
  };
  return labels[status];
}

export function getStatusClass(status: TransactionStatus): string {
  const classes: Record<TransactionStatus, string> = {
    COMPLETED: 'completed',
    CANCELLED: 'cancelled',
    FAILED: 'failed',
    PAID: 'paid',
    RECEIVED: 'received',
    REFUNDED: 'refunded',
    REVERSED: 'reversed',
  };
  return classes[status];
}
