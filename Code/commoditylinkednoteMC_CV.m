function [fairvalue, CI , elapsedTime, discpayoffs] = commoditylinkednoteMC_CV ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[fairvalue, CI , elapsedTime, discpayoffs] = commoditylinkednoteMC_CV ...
% (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,seed)
%Calculates the fair value for commmodity linked note price using a control variate.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs:
% Cu_P: Initial underlying price of copper
% Al_P: Initial underlying price of aluminum
% Zn_P: Initial underlying price of asset zinc
% Cu_q: Continuously compounded dividend yield of asset 1
% Al_q: Continuously compounded dividend yield of asset 2
% Zn_q: Continuously compounded dividend yield of asset 3
% r: Continuously Compounded Annual Risk-free Interest Rate
% T: Expiration
% Cu_sigma: Annualized volatility of asset 1
% Al_sigma: Annualized volatility of asset 2
% Zn_sigma: Annualized volatility of asset 3
% Cu_Al_rho: Correlation between asset 1 and asset 2
% Al_Zn_rho: Correlation between asset 2 and asset 3
% Cu_Zn_rho: Correlation between asset 1 and asset 3
% N: Number of iterations
% seed: Random number seed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Outputs:
% fairvalue: The fair value for the Commodity linked note
% CI: Confidence interval for spread option price
% elapsedTime: Elapsed time in second
% discpayoffs: A vector containing each iteration for spread option price
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
% Reset the initial seed.
rng(seed);
% Precompute parameters.
nuCu=r-Cu_q-Cu_sigma.^2./2; nuAl=r-Al_q-Al_sigma.^2./2; nuZn=r-Zn_q-Zn_sigma.^2./2;
nuCuT=nuCu.*T; nuAlT=nuAl.*T; nuZnT=nuZn.*T;
sigmaCusqrtT=Cu_sigma.*sqrt(T);
sigmaAlsqrtT=Al_sigma.*sqrt(T);
sigmaZnsqrtT=Zn_sigma.*sqrt(T);
% Calculate the correlated random variable
Z=randn(3,N); % Uncorrelated standard normal
L11=1;
L21=Cu_Al_rho;
L22=sqrt(1-Cu_Al_rho.^2);
L31=Cu_Zn_rho;
L32=(Al_Zn_rho-Cu_Al_rho.*Cu_Zn_rho)./sqrt(1-Cu_Al_rho.^2);
L33=sqrt(1-L31.^2-L32.^2);
L=[L11 0 0; L21 L22 0; L31 L32 L33];
X=L*Z; % Correlated standard normal
% Correlated underling prices
SCuT = Cu_P* exp(nuCuT+sigmaCusqrtT.*X(1,:));
SAlT = Al_P* exp(nuAlT+sigmaAlsqrtT.*X(2,:));
SZnT = Zn_P* exp(nuZnT+sigmaZnsqrtT.*X(3,:));
% Calculate the payoff of the control variate, a portfolio of option
% collars
CuCollar = max(min(((SCuT-Cu_P)/Cu_P)+1,1.25),1);
AlCollar = max(min(((SAlT-Al_P)/Al_P)+1,1.25),1);
ZnCollar = max(min(((SZnT-Zn_P)/Zn_P)+1,1.25),1);
payoffCV = exp(-r.*T).*400.*((1/3).* CuCollar + ...
           (1/3).* AlCollar + ...
           (1/3) .* ZnCollar); 
% Calculate trial payoff
discpayoffs= exp(-r.*T).*400.*max((1/3).*min(SCuT./Cu_P,1.25)...
                                +(1/3).*min(SAlT./Al_P,1.25)...
                                +(1/3).*min(SZnT./Zn_P,1.25),1);
%Calculate c_coeff
VarCov=cov(payoffCV,discpayoffs);
c_coeff = -VarCov(1,2)./var(payoffCV);
%Simulate prices using the control variate.
% Calculate the correlated random variable
Z=randn(3,N); % Uncorrelated standard normal
L11=1;
L21=Cu_Al_rho;
L22=sqrt(1-Cu_Al_rho.^2);
L31=Cu_Zn_rho;
L32=(Al_Zn_rho-Cu_Al_rho.*Cu_Zn_rho)./sqrt(1-Cu_Al_rho.^2);
L33=sqrt(1-L31.^2-L32.^2);
L=[L11 0 0; L21 L22 0; L31 L32 L33];
X=L*Z; % Correlated standard normal
% Correlated underling prices
SCuT = Cu_P* exp(nuCuT+sigmaCusqrtT.*X(1,:));
SAlT = Al_P* exp(nuAlT+sigmaAlsqrtT.*X(2,:));
SZnT = Zn_P* exp(nuZnT+sigmaZnsqrtT.*X(3,:));
% Calculate the payoff of the control variate, a portfolio of option
% strangles
CuCollar = max(min(((SCuT-Cu_P)/Cu_P)+1,1.25),1);
AlCollar = max(min(((SAlT-Al_P)/Al_P)+1,1.25),1);
ZnCollar = max(min(((SZnT-Zn_P)/Zn_P)+1,1.25),1);
payoffCV = exp(-r.*T).*400.*((1/3).*CuCollar + ...
           (1/3).* AlCollar + ...
           (1/3).* ZnCollar); 
%Find theoretical Expectation
[~, Cu_put] = blsprice(Cu_P,Cu_P,r,T,Cu_sigma,Cu_q);
[Cu_call, ~] = blsprice(Cu_P,Cu_P*1.25,r,T,Cu_sigma,Cu_q);
[~, Al_put] = blsprice(Al_P,Al_P,r,T,Al_sigma,Al_q);
[Al_call, ~] = blsprice(Al_P,Al_P*1.25,r,T,Al_sigma,Al_q);
[~, Zn_put] = blsprice(Zn_P,Zn_P,r,T,Zn_sigma,Zn_q);
[Zn_call, ~] = blsprice(Zn_P,Zn_P*1.25,r,T,Zn_sigma,Zn_q);
TheoCV = 400+(400/3/Cu_P)*(Cu_call-Cu_put)+(400/3/Al_P)*(Al_call-Al_put)+(400/3/Zn_P)*(Zn_call-Zn_put);
%Find new discpayoffs using TheoCV
discpayoffs= exp(-r.*T).*400.*max((1/3).*min(SCuT./Cu_P,1.25)...
                                +(1/3).*min(SAlT./Al_P,1.25)...
                                +(1/3).*min(SZnT./Zn_P,1.25),1)...
                                + c_coeff.*(payoffCV-TheoCV);

[fairvalue,~,CI]=normfit(discpayoffs); % Mean and confidence interval
elapsedTime=toc;
end