% ��һ���� ��dcc(m)�Ĳ���>dcc [PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,Rt,Qt]=dcc(m,[],1,0,1,1,0,1,2,'2-stage','none');
% �ڶ����� ȡ2012/4/9��2013/4/9������ ���� Ht=Cov(n) 
% �������� ��Rt=Corr(n)
% ���Ĳ��� ht=diag(Ht,0)
% ���岽�� ��ht�Ͳ�����ht+1 (���3x1����)
% �������� ��Rt�Ͳ�����Rt+1 �����3x3����
% ���߲��� ��diag(sqrt(ht))�ϳ� Dt 3x3�ľ��󣬳��˶Խ���������Ϊ��
% �ڰ˲��� ���result=D(k)*Rt(k)*D(k) ��t+1��Ԥ��ֵ
% ��� ��n�����ƶ�һ�� Ȼ��ͬ���Ĳ��������t+2��Ԥ��ֵ һֱѭ������260��
%ht1=bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(n(end,:).^2)')),bsxfun(@times,beta',dht))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��̬parameters���Լ�����Ht&Rt
% ����ǲ��ö�̬��parameters����parameters����ÿ�����ݵ�ǰ9��������
% Ht��Rt�����Լ����㷽ʽ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;

%data&w
Equity_w=[1/3;1/3;1/3];

ww=Equity_w;
data=Equity_LP;
% para
m=2;
l=0;
n=2;

p=2;
o=0;
q=2;
Var_startIndex=2349; % 
[Var_lens,Var_cols]=size(data); % 
k=Var_cols;
% save DCC Result
Equity_DCC_PARAMETERS=[];
Equity_DCC_Ht=[];
Equity_DCC_Rt=[];
Equity_DCC_Ao=[];
Equity_DCC_Go=[];
Equity_DCC_Bo=[];
Equity_DCC_Ro=[];
ht=[];
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
       
    mData=data(i-Var_startIndex+1:i,:);
    mHis=mData(end-261:end,:);
    Cov_PF=cov(mHis);    
    Result_His1(index,1)=ww'*Cov_PF*ww; % 
    % 1
    [PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,RRt,QQt,Ao,Go,Bo,Ro]=dcc(mData,[],p,o,q,m,l,n,2,'2-stage','none');
    
    Equity_DCC_PARAMETERS(:,:,index)=PARAMETERS;
    Equity_DCC_Ht(:,:,:,index)=HtTemp;
    Equity_DCC_Rt(:,:,:,index)=RRt;
    Equity_DCC_Ao(:,:,index)=Ao;
    Equity_DCC_Go(:,:,index)=Go;
    Equity_DCC_Bo(:,:,index)=Bo;
    Equity_DCC_Ro(:,:,index)=Ro;
    
    % 2
    %Ht=cov(n);
    % 3
    %Rt=corr(n);
    % 4
    %dht=diag(Ht,0);
    % 5
    gScale=DIAGNOSTICS.gScale;   
    scale = (1-sum(Ao)-sum(Bo)) - gScale*sum(Go);
    scale = sqrt(scale); 
    scale=scale'*scale;
    w=[];
    alpha=[];
    beta=[];
    volParameters=[];
    ht1=[];
    intcept=[];
    eps=[];
    BB=[];
    AA=[];
    epsilon=[];
    count = 0;
    for j=1:k
        count = count + p+o+q+1;
    end
    garchParameters = PARAMETERS(1:count);
    offset = 0;
    count = p+o+q+1;
    for j=1:k       
        volParameters(:,:,j) = garchParameters(offset + (1:count));        
        % w������ά����ͬ
        w(j)=volParameters(1,1,j);
        offset = offset+count;
    end
    
    intcept=bsxfun(@times,corr_ivech(Ro),scale);
   
    %AA=bsxfun(@times,eps,Ao);
    %BB=bsxfun(@times,Rt,Bo);  
    for j=1:p
        m2=data(i-261-j+1:i-j+1,:);
        Ht=cov(m2);
        Rt=corr(m2);
        dht=diag(Ht,0);
        alpha=[];
        beta=[];
        for kl=1:k
            tempPara=volParameters(:,:,kl);
            %parameters(j+1)
            %parameters(j+p+1)
            %parameters(j+p+o+1)
           alpha(kl)=tempPara(1+j);
           beta(kl)=tempPara(1+j+p);
        end              
        epsilon(1:Var_cols,1,i)=bsxfun(@rdivide,m2(end,:)',sqrt(dht));
        eps=epsilon(1:Var_cols,1,i)*epsilon(1:Var_cols,1,i)';
        if j==1
            ht(1:Var_cols,1,index)=bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(m2(end,:).^2)')),bsxfun(@times,beta',dht));
            BB=bsxfun(@times,Rt,Bo(j));
            AA=bsxfun(@times,eps,Ao(j));
        else
            ht(1:Var_cols,1,index)=bsxfun(@plus,ht(1:Var_cols,1,index),bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(m2(end,:).^2)')),bsxfun(@times,beta',dht)));
            BB=bsxfun(@plus,BB,bsxfun(@times,Rt,Bo(j)));
            AA=bsxfun(@plus,AA,bsxfun(@times,eps,Ao(j)));
        end
    end

   Rt1(1:Var_cols,1:Var_cols,index)=bsxfun(@plus,intcept,bsxfun(@plus,AA,BB));
   Dt1(:,:,index)=diag(sqrt(ht(1:Var_cols,1,index)));
   result_DCC(:,:,index)=Dt1(:,:,index)*Rt1(1:Var_cols,1:Var_cols,index)*Dt1(:,:,index);
   Result(index)=ww'*result_DCC(:,:,index)*ww;
   disp(i);
end 



