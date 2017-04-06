function [meanreturn, meanexcessreturn, stdexcessreturn, sharpe, payoff, elapsedTime] = CLNRiskReturnPartD ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[fairvalue, CI , elapsedTime, payoff] = CLNRiskReturnAnalysis ...
% (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed)
% Calculates various risk/return parameters on the commodity linked note.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs:
% Cu_P: Initial underlying price of copper
% Al_P: Initial underlying price of aluminum
% Zn_P: Initial underlying price of zinc
% muCu: Expected annual return of copper
% muAl: Expected annual return of aluminum
% muZn: Expected annual return of zinc
% r: Continuously Compounded Annual Risk-free Interest Rate
% T: Expiration
% Cu_sigma: Annualized volatility of asset 1
% Al_sigma: Annualized volatility of asset 2
% Zn_sigma: Annualized volatility of asset 3
% Cu_Al_rho: Correlation between asset 1 and asset 2
% Al_Zn_rho: Correlation between asset 2 and asset 3
% Cu_Zn_rho: Correlation between asset 1 and asset 3
% N: Number of iterations
% par: the par value of the commodity linked note
% seed: Random number seed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Outputs:
% Mean Return to Investment: the mean annual return
% Mean Excess Return: the mean excess return
% Standard Deviation of Excess Return: the standard deviation of excess
% return
% Sharpe Ratio: the Sharpe Ratio
% Payoff: MC return simulation returns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
% Reset the initial seed.
rng(seed);
% Precompute parameters.
nuCu=muCu-Cu_sigma.^2./2; nuAl=muAl-Al_sigma.^2./2; nuZn=muZn-Zn_sigma.^2./2;
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
% Calculates payoff.
payoff= par.*max((1/3).*min((SCuT)./Cu_P,1.50)...
                    +(1/3).*min((SAlT)./Al_P,1.25)...
                    +(1/3).*min((SZnT)./Zn_P,1.25),1);
% Calculates risk and return parameters
meanreturn = (mean(payoff)/par)^(1/3)-1; 
meanexcessreturn = (mean(payoff)/par)^(1/3)-r-1;
stdexcessreturn = std((payoff/par).*sqrt(3)-r-1);
sharpe = meanexcessreturn/stdexcessreturn;
elapsedTime=toc;
end