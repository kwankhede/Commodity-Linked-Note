
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P measure
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%111111111111111111111111111111111
disp('1. a) Mrs Smith is our first client. Displayed below are the values for P Measure' )
 
Cu_P=5000;Al_P=1600;Zn_P=2000;muCu=0.1;muAl=0.1;muZn=.1;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;par=1000000;seed=777;
 
[meanreturn, meanexcessreturn, ~, sharpe,~] = CLNRiskReturnAnalysis(Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,...
    Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
 
disp('her Mean Return is') 
disp(meanreturn)
disp('her Mean Excess Return is ')
disp(meanexcessreturn)
disp('her sharpe ratio is')
disp(sharpe)
 
disp('Recommendation: Mrs Smith will not be happy with the performance of the note. We must offer her better terms. Changing weights and caps is not effective because all three commodities have the same return/risk assumptions. We must change the minimum return to get better results.')
 
[meanreturn, meanexcessreturn, ~, sharpe,~] = CLNRiskReturnAnalysisclient1Pmeasure ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);

disp('These are the values after the recommendation')

 
disp('her Mean Return is') 
disp(meanreturn)
disp('her Mean Excess Return is ')
disp(meanexcessreturn)
disp('her sharpe ratio is')
disp(sharpe)
 
disp(' b)Now we do the Q measure using the new payoff')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;seed=777;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;
 
 
[~,~,~,fairvalue,~] = commoditylinkednoteMCQmeasureClient1 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed);
 
disp('her fairvalue is') 
disp(fairvalue)
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%2222222222222222222222222
 
disp('2.a) Mr.Johnson is our second client. Displayed below are the values for P Measure')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;muCu=.03;muAl=.03;muZn=.03;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;par=1000000;seed=777;
 
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysis(Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,...
    Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp(' his sharpe ratio is')
disp(sharpe)
 
disp('Recommendation: Mr Johnson will not be happy with the performance of the note. We must offer him better terms. Changing weights and caps is not effective because all three commodities have the same return/risk assumptions. We must change the minimum return to get better results.') 
 
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysisclient2Pmeasure ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
 
disp('These are the values after the recommendation')
disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp(' his sharpe ratio is')
disp(sharpe)
 
disp('b)Now we do the Q measure using the new payoff')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;seed=777;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;
 
[~,~,~,fairvalue,~] = commoditylinkednoteMCQmeasureClient2 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed);
 
disp('his fairvalue is') 
disp(fairvalue)
 
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%33333333333333333333333333333333333333333
 
 
disp('3. a) Ms. Williams is our third client. Displayed below are the values for P Measure')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;muCu=.03;muAl=.03;muZn=.03;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0;
Al_Zn_rho=0;Cu_Zn_rho=0;N=1000;par=1000000;seed=777;
 
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysis(Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,...
    Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
disp('her Mean Return is') 
disp(meanreturn)
disp('her Mean Excess Return is')
disp(meanexcessreturn)
disp(' her sharpe ratio is')
disp(sharpe)
 
disp('Recommendation: Ms. Williams will not be happy, we need to remove the minimum language to allow her to get full return stream to be realized. Considering correlation is 0, and not worried about all assets taking off at the same time')
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysisclient3Pmeasure ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);

disp('These are the values after the recommendation')

 
 
disp('her Mean Return is') 
disp(meanreturn)
disp('her Mean Excess Return is')
disp(meanexcessreturn)
disp(' her sharpe ratio is')
disp(sharpe)
 
disp('b)Now we do the Q measure using the new payoff')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0;
Al_Zn_rho=0;Cu_Zn_rho=0;N=1000;seed=777;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;
 
[~,~,~,fairvalue,~] = commoditylinkednoteMCQmeasureClient3 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed);
 
disp('her fairvalue is') 
disp(fairvalue)
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%444444444444444444444444444444444444444444
 
 
disp('4. a) Mr.Jones is our fourth client. Displayed below are the values for P Measure')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;muCu=.1;muAl=.03;muZn=.03;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;par=1000000;seed=777;
 
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysis(Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,...
    Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp('his sharpe ratio is')
disp(sharpe)
 
disp('Recommendation: Mr.Jones has a low Sharpe ratio. We need to change copper cap to realize more of expected return of copper since it has a higher return.')
 
[meanreturn, meanexcessreturn, ~, sharpe] = CLNRiskReturnAnalysisclient4Pmeasure ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);
disp('These are the values after the recommendation')

disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp('his sharpe ratio is')
disp(sharpe)
 
 
disp('b)Now we do the Q measure using the new payoff')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;seed=777;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;
 
[~,~,~,fairvalue,~] = commoditylinkednoteMCQmeasureClient4 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed);
 
disp('her fairvalue is') 
disp(fairvalue)
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555555555555555555555555555555555555555
 
 
 
disp('5. a) Miss Brown is our fifth client. Displayed below are the values for P Measure')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;muCu=.1;muAl=.1;muZn=.1;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;par=1000000;seed=777;
 
 
[meanreturn, meanexcessreturn,~, sharpe] = CLNRiskReturnAnalysis(Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,...
    Al_sigma,Zn_sigma,Cu_Al_rho,Al_Zn_rho,Cu_Zn_rho,N,par,seed);
 
 
disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp(' her sharpe ratio is')
disp(sharpe)
 
disp('Recommendation: Miss Brown might not be happy as the expectations are too low. We must change cap to realize more upside of zinc as that will have a comparatively low return')
 
[meanreturn, meanexcessreturn,~, sharpe] = CLNRiskReturnAnalysisclient5Pmeasure ...
 (Cu_P,Al_P,Zn_P,muCu,muAl,muZn,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,par,seed);

 disp('These are the values after the recommendation')

 
disp('his Mean Return is') 
disp(meanreturn)
disp('his Mean Excess Return is')
disp(meanexcessreturn)
disp(' her sharpe ratio is')
disp(sharpe)
 
disp(' b)Now we do the Q measure using the new payoff')
 
Cu_P=5000;Al_P=1600;Zn_P=2000;r=.03;T=3;
Cu_sigma=0.25;Al_sigma=0.25;Zn_sigma=0.25;Cu_Al_rho=0.8641;
Al_Zn_rho=0.7720;Cu_Zn_rho=0.7786;N=1000;seed=777;Cu_q=0.015;Al_q=0.015;Zn_q=0.015;
 
 
[~,~,~,fairvalue,~] = commoditylinkednoteMCQmeasureClient5 ...
 (Cu_P,Al_P,Zn_P,Cu_q,Al_q,Zn_q,r,T,Cu_sigma,Al_sigma,Zn_sigma,Cu_Al_rho,...
 Al_Zn_rho,Cu_Zn_rho,N,seed);
 
disp('her fairvalue is') 
disp(fairvalue)
 
 
 



