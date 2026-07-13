from sklearn.linear_model import HuberRegressor
import numpy as np

class PostgresEstimator:
    """
    - For cardinality: just pass through root.card_est.
    - For cost→time: fit a HuberRegressor on root.cost_est → actual_time.
    """
    def __init__(self):
        self._time_model = HuberRegressor()

    def fit(self, roots, true_times):
        # roots: list of PlanNode, each has .cost_est
        X = np.array([r.cost_est for r in roots]).reshape(-1,1)
        y = np.array(true_times, dtype=float)
        self._time_model.fit(X, y)

    def predict_time(self, roots):
        X = np.array([r.cost_est for r in roots]).reshape(-1,1)
        return self._time_model.predict(X).tolist()

    def predict_card(self, roots):
        # roots: list of PlanNode, each has .card_est
        return [r.card_est for r in roots]
