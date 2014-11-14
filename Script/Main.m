% ������
clear;
clc;
% �Ƿ������ʷ
his=0;
DCC1011=0;
DCC101Every=0;
BEKK101=1;
%��ʼ������
InitData;

%3 ������ʷ
if his==1
    [Alternative_His]=Cal_His(Alternative_LP,[],Alternative_w,[],'Alternative');
    [Equity_His]=Cal_His(Equity_LP,[],Equity_w,[],'Equity');
    [FixIncome_His]=Cal_His(FixIncome_LP,[],FixIncome_w,[],'FixIncome');
    [NewPF_His_Defensive,NewPF_His_Offensive]=Cal_His(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF');
    [OldPF_His_Defensive,OldPF_His_Offensive]=Cal_His(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF');
end

%4 DCC 
% DCC101 1
if DCC1011==1
    [Alternative_DCC101_1]=Cal_DCC_1(Alternative_LP,[],Alternative_w,[],'Alternative',1,0,1);
    [Equity_DCC101_1]=Cal_DCC_1(Equity_LP,[],Equity_w,[],'Equity',1,0,1);
    [FixIncome_DCC101_1]=Cal_DCC_1(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,0,1);
    [NewPF_DCC101_1_Defensive,NewPF_DCC101_1_Offensive]=Cal_DCC_1(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,0,1);
    [OldPF_DCC101_1_Defensive,OldPF_DCC101_1_Offensive]=Cal_DCC_1(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,0,1);
end
if DCC101Every==1
    [Alternative_DCC101_1]=Cal_DCC_Every(Alternative_LP,[],Alternative_w,[],'Alternative',1,0,1);
    [Equity_DCC101_1]=Cal_DCC_Every(Equity_LP,[],Equity_w,[],'Equity',1,0,1);
    [FixIncome_DCC101_1]=Cal_DCC_Every(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,0,1);
    [NewPF_DCC101_1_Defensive,NewPF_DCC101_1_Offensive]=Cal_DCC_Every(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,0,1);
    [OldPF_DCC101_1_Defensive,OldPF_DCC101_1_Offensive]=Cal_DCC_Every(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,0,1);
end
%BEKK
if BEKK101==1
    [Alternative_BEKK101_1]=Cal_BEKK_1(Alternative_LP,[],Alternative_w,[],'Alternative',1,0,1);
    [Equity_BEKK101_1]=Cal_BEKK_1(Equity_LP,[],Equity_w,[],'Equity',1,0,1);
    [FixIncome_BEKK101_1]=Cal_BEKK_1(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,0,1);
    [NewPF_BEKK101_1_Defensive,NewPF_BEKK101_1_Offensive]=Cal_BEKK_1(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,0,1);
    [OldPF_BEKK101_1_Defensive,OldPF_BEKK101_1_Offensive]=Cal_BEKK_1(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,0,1);
end
%BEKK
if Gogarch11==1
    [Alternative_Gogarch11_1]=Cal_Gogarch_1(Alternative_LP,[],Alternative_w,[],'Alternative',1,1);
    [Equity_Gogarch11_1]=Cal_Gogarch_1(Equity_LP,[],Equity_w,[],'Equity',1,1);
    [FixIncome_Gogarch11_1]=Cal_Gogarch_1(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,1);
    [NewPF_BEKK101_1_Defensive,NewPF_Gogarch11_1_Offensive]=Cal_Gogarch_1(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,1);
    [OldPF_BEKK101_1_Defensive,OldPF_Gogarch11_1_Offensive]=Cal_Gogarch_1(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,1);
end
