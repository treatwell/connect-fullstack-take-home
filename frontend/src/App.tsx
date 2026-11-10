import { BalanceOverview } from './components/BalanceOverview/BalanceOverview';
import './App.css';

const SUPPLIER_ID = 1001;

function App() {
  return (
    <div className="app">
      <BalanceOverview supplierId={SUPPLIER_ID} />
    </div>
  );
}

export default App;
