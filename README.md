# MATLAB-files-for-thesis
Optimization algorithms I built for the numerical study described in my paper: "Strategic Behaviour in a Tandem Queue with Alternating Server" (With R. Hassin and U. Yechiali, forthcoming in the Queueing Systems magazine Special Issue: “Strategic Queueing: Game-Theoretic Models in Queueing Theory” (2020)).

Abstract:
This paper considers an unobservable tandem queueing system with an alternating server. We study the strategic customer behaviour under two threshold-based operating policies, applied by a proﬁt-maximizing server, while waiting and switching costs are taken into account. Under the Exact-N policy the server serves exactly N customers in the ﬁrst stage before switching to provide second-stage service to these customers, which leads to a mixture of 'Follow-The-Crowd' and 'Avoid-The-Crowd' customers’ behaviours. In contrast, under the N-Limited policy the server switches also when the ﬁrst queue is emptied, making this regime work-conserving and leading only to 'Avoid-The-Crowd' behaviours. Performance measures are obtained using Matrix Geometric methods for both policies and any threshold N, while for the sequential service( when N = 1) explicit expressions are achieved. It is shown that the system’s stability condition is independent of N, nor of the switching policy. Optimization performances in equilibrium, under each of these switching policies, are analyzed and compared by a numerical study.

There are two kind of matlab files in this repository:

1. Pairs of calculation and optimization functions (in every pair a function for each pne of the policies):
  * Opt_Val - Find the maximal profit and the matching price, threshold and equilibrium effective arrival rate given the system's  parameters. The function finds the optimal values by itterating on the possible set of thresholds (small integers) and calling the next function.
  * Optimal_p - Find the maximal profit and the matching price and equilibrium effective arrival rate given a threshold and the system's parameters. The function finds the optimal values by using a binaric search on the range of prices with a positive profit in equilibrium. To find the equilibrium effective arrival rate it calls the next function.
    * lambda_eff - Find the effective arrival rate in the stable positive equilibrium, i.e., the larger value of effective arrival rate where the customers' utility is zero and they are indifferent of joining the system. To calculate the customers' utility it calls the next function.
    * Calc_W - Uses Matrix Geometrics methods and successive substitutions algorithm to find the system's steady-state probabilities and using that to calculate the mean sojourn time for a customer in the system.
    
2. Scripts for plotting graphs:
  * graph_delta_r_zones - Plot the difference between the optimal profits under the two policies as a function of the system's parameters.
  * graph_r_N - Plot the optimal profit under the two policies as a function of the threshold.
  * graph_r_p_new - Plot the optimal price and  equilibrium effective arrival rate as a function of the price.
  * CheckWinN - Plot the mean sojourn time in each of the queues, as a function of the effective arrival rate, for different values of the threshold.
