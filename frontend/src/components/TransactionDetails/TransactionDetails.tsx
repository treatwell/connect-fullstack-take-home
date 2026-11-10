import type { TransactionEntry } from '../../types/transaction';
import { formatCurrency } from '../BalanceOverview/balanceUtils';
import { getTransactionDisplay, getStatusLabel, getStatusClass } from '../TransactionCard/transactionCardUtils';
import styles from './TransactionDetails.module.css';
import { useEffect } from 'react';

type TransactionDetailsProps = {
  transaction: TransactionEntry;
  onClose: () => void;
};

export function TransactionDetails({ transaction, onClose }: TransactionDetailsProps) {
  const display = getTransactionDisplay(transaction.type, transaction.status);
  const statusClass = getStatusClass(transaction.status);

  useEffect(() => {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', handleEscape);
    return () => document.removeEventListener('keydown', handleEscape);
  }, [onClose]);

  return (
    <div className={styles.overlay} onClick={onClose}>
      <div className={styles.panel} onClick={(e) => e.stopPropagation()}>
        <div className={styles.header}>
          <p className={styles.title}>Transaction Details</p>
          <span className={styles.closeBtn} onClick={onClose}>&times;</span>
        </div>

        <div className={styles.body}>
          <div className={styles.hero}>
            <span className={styles.heroIcon}>{display.icon}</span>
            <span className={styles.heroLabel}>{display.label}</span>
            <span className={`${styles.heroBadge} ${styles[statusClass]}`}>
              {getStatusLabel(transaction.status)}
            </span>
          </div>

          <div className={styles.amount}>
            {formatCurrency(transaction.amount)}
          </div>

          <div className={styles.rows}>
            {transaction.reference && (
              <DetailRow label="Reference" value={transaction.reference} />
            )}
            <DetailRow label="Description" value={transaction.description} />
            <DetailRow label="Date" value={transaction.fulfilmentDate} />
            <DetailRow label="Net Amount" value={formatCurrency(transaction.netAmount)} />

            {transaction.paymentMethod && (
              <DetailRow
                label="Payment Method"
                value={formatPaymentMethod(transaction.paymentMethod)}
              />
            )}

            {transaction.type === 'ORDER' && transaction.feeAmount > 0 && (
              <DetailRow
                label="Commission"
                value={`${formatCurrency(transaction.feeAmount)} (${formatCommissionPercent(transaction.feeAmount, transaction.amount)})`}
              />
            )}

            {transaction.type === 'ORDER' && (
              <DetailRow
                label="New Customer"
                value={transaction.newCustomer ? 'Yes' : 'No'}
              />
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function DetailRow({ label, value }: { label: string; value: string }) {
  return (
    <div className={styles.row}>
      <span className={styles.rowLabel}>{label}</span>
      <span className={styles.rowValue}>{value}</span>
    </div>
  );
}

function formatPaymentMethod(method: string): string {
  return method.replace(/_/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase());
}

function formatCommissionPercent(fee: number, gross: number): string {
  if (gross === 0) return '0%';
  const pct = (fee / gross) * 100;
  return `${pct % 1 === 0 ? pct.toFixed(0) : pct.toFixed(1)}%`;
}
