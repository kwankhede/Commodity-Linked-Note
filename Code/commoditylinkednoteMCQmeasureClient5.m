function [meanreturn,meanexcessreturn,stdexcessreturn,fairvalue,sharpe, CI , elapsedTime, discpayoffs] = commoditylinkednoteMCQmeasureClient5 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[fairvalue, CI , elapsedTime, discpayoffs] = commoditylinkednoteMC ...
% (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,seed)
%Calculates the fair value for commmodity linked note price.
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
SCuT=Cu_P* exp(nuCuT+sigmaCusqrtT.*X(1,:));
SAlT=Al_P* exp(nuAlT+sigmaAlsqrtT.*X(2,:));
SZnT=Zn_P* exp(nuZnT+sigmaZnsqrtT.*X(3,:));
% Calculates discpayoffs, option price, and confidence interval.
discpayoffs= exp(-r.*T).*1000000.*max((1/3).*min((SCuT)./Cu_P,1.25)...
                    +(1/3).*min((SAlT)./Al_P,1.25)...
                    +(1/3).*min((SZnT)./Zn_P,1.5),1);
[fairvalue,CI]=normfit(discpayoffs); % Mean and confidence interval
elapsedTime=toc;
meanreturn = (mean(discpayoffs)/1000000)^(1/3)-1; 
meanexcessreturn = (mean(discpayoffs)/1000000)^(1/3)-r-1;
stdexcessreturn = std((discpayoffs/1000000).*sqrt(3)-r-1);
sharpe = meanexcessreturn/stdexcessreturn;
end
