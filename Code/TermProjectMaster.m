%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% This is the Master file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Term project by Cheshta Chauhan, Dan DeRose, Kapil Wankhede, and Raj Dadireddy')

disp('Part A')

format compact

Cu_P=5000;Al_P=1600;Zn_P=2000;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;r=0.03;
T=3;Cu_sigma=0.2718;Al_sigma=0.2143;Zn_sigma=0.2817;
Cu_Al_rho=0.8641;Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;
N=1000;seed=777;

[fairvalue, CI, elapsedTime,discpayoffs] = commoditylinkednoteMC(Cu_P,...
Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
Al_Zn_rho,Cu_Zn_rho,N,seed);

N=floor(std(discpayoffs).^2.*1.96.^2./0.01.^2);

tic;

[fairvalue, CI, elapsedTime] = commoditylinkednoteMC(Cu_P,...
Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
Al_Zn_rho,Cu_Zn_rho,N,seed);

elapsedTime = toc;

disp('The fair value of the commodity linked note is')
disp(fairvalue)
disp('In order to decrease the confidence interval, a large N is needed')
disp(N)
disp('The CI is')
disp(CI)
disp('The commodity linked note currently sells at a discount to face value of $400')
disp('This MC simulation took a few seconds')
disp(elapsedTime)

disp('Part B')
disp('Our preferred variance reduction technique is using a basket of option collars as a control variate.')
N=1000;
[fairvalue, CI, elapsedTime,discpayoffs] = commoditylinkednoteMC_CV(Cu_P,...
Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
Al_Zn_rho,Cu_Zn_rho,N,seed);

N=floor(std(discpayoffs).^2.*1.96.^2./0.01.^2);

tic;

[fairvalue, CI, elapsedTime,discpayoffs] = commoditylinkednoteMC_CV(Cu_P,...
Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
Al_Zn_rho,Cu_Zn_rho,N,seed);

elapsdTime = toc;

disp('The fair value of the commodity linked note using this control variate is')
disp(fairvalue)
disp('The N necessay for a small CI is significatly smaller')
disp(N)
disp('The CI is')
disp(CI)
disp('This MC simulation with variation reduction took significantly less time')
disp(elapsedTime)

%%%%%%%%%PART C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Part C')
partCPandQmeasure
%%%%%%%%%PART C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Part D')
disp('First, it is necessary to evaluate the performace of the commodity linked note')
disp('We used the following parameters: ')
disp('closing prices as of Wednesday, November 23,')
disp('mu is the average annual log returns since 1994,')
disp('volatility is the average annual log variance since 1994,')
disp('and correlation is correlation coefficient of daily prices since 1994')
disp('We assume a 3 year time horizon for our client and use the 3 year Treasury')
disp('yield as of Wednesday, November 23 as our risk free rate.')
disp('We slighly modified our standard CLN by increasing the cap for copper')
disp('because copper has the greatest return per unit of volatility')
disp('This will make our CLN more attractive to Miss Brown')

Cu_P=5633;Al_P=1736;Zn_P=2615;muCu=0.045;muAl=0.0168;muZn=0.035;
r=.0139;T=3;Cu_sigma=0.25;Al_sigma=0.19;Zn_sigma=0.27;Cu_Al_rho=0.80;
Al_Zn_rho=0.821;Cu_Zn_rho=0.81;N=2438;par=1000000;seed=777;

[meanreturn, meanexcessreturn, stdexcessreturn, sharpe, payoff, elapsedTime] = CLNRiskReturnPartD ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);


disp('The mean return is ')
disp(meanreturn)
disp('The mean excess return is ')
disp(meanexcessreturn)
disp('The standard deviation of the excess return is')
disp(stdexcessreturn)
disp('The Sharpe ratio is')
disp(sharpe)

disp('The expected return is sufficiently high to consider an investment by Miss Brown.')
disp('Even though the Sharpe ratio is not spectacular on its own, it is important')
disp('to consider as a diversifier to equities to enhance Miss Browns investment returns.')
disp('To understand if this CLN is a diversifier, it is important to know')
disp('the correlation coefficient with the stock market')

stocks = readtable('table.csv');
stocks = stocks(1:2438,7);
stocks = table2array(stocks);
stocks = wrev(stocks);
payoff = transpose(payoff);
corr = corrcoef(payoff,stocks);

disp('The correlation coefficient is')
disp(corr(1,2))

disp('Our CLN has a very low correlation coefficient with a positive expected return.')
disp('It will be a great diversifier!')

disp('In order to determine how much CNL is best for Miss Brown to purchase,')
disp('it is necessay to calculate the variance of the CLN and equities.')

CLNstd = stdexcessreturn;
CLNvar = CLNstd^2;

for i = 2:2438
    stocksdaily(i) = stocks(i)/stocks(i-1);
end

stocksdaily(1,1) = 1;
stocksln = log(stocksdaily);
stocksstd = std2(stocksln)*sqrt(252);
stocksvar = stocksstd^2;
stocksmean = exp(mean(stocksln)*252 + stocksvar/2) -1;

disp('The variance of the CLN is')
disp(CLNvar)
disp('The variance of equities is over the last 10 years is')
disp(stocksvar)

cov = corr(1,2)*sqrt(stocksvar)*sqrt(CLNvar);

wCLN = (stocksvar - cov)/(stocksvar + CLNvar - 2 * cov);
wStocks = 1 - wCLN;

disp('In a 2 asset risky portfolio, the most efficient allocation of capital')
disp('should be as follows:')
disp('the weight of CLN is')
disp(wCLN)
disp('the weight of stocks is')
disp(wStocks)
disp('It is in Miss Browns best interest to purchase $4.63 million of our CLN product.')

expPortreturn = wCLN*meanreturn + wStocks*stocksmean;

disp('Miss Browns expected return will be')
disp(expPortreturn)
disp('with a standard deviation of')

portstd = sqrt(wCLN^2 * CLNvar + wStocks^2 * stocksvar + 2 * wCLN * wStocks * cov);

disp(portstd)


