function [Gogarch_Result1,Gogarch_Result2] = Cal_Gogarch_Every(data,Var_startIndex,weight1,weight2,name,p,q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��̬parameters���Լ�����Ht&Rt
% ����ǲ��ö�̬��parameters����parameters����ÿ�����ݵ�ǰ9��������
% Ht��Rt�����Լ����㷽ʽ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(p)
    p=1;
end
if isempty(q)
    q=1;
end

if isempty(Var_startIndex)
    Var_startIndex=2349;
end

[Var_lens,Var_cols]=size(data); %
k=Var_cols;
% new data 
newData=[];
for i=260:Var_lens
   for j=1: Var_cols
       tempData=data(i-259:i,j);
        Cov_PF=cov(tempData);  
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-259,j)=epsilon;
   end
end
% save Gogarch Result
Equity_Gogarch_PARAMETERS=[];
Equity_Gogarch_Z=[];

ht=[];
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
       
    mData=newData(index+261*5:index+261*8,:);
    m_new2=newData(i-520:i-259,:);
   [parameters,ll,Ht,VCV,scores,Z] = gogarch(mData,p,q);%(newData,numfactors,p,o,q);
    Equity_Gogarch_PARAMETERS(:,:,index)=parameters;
    Equity_Gogarch_Z(:,:,:,index)=Z;
    paraA=[];
    paraB=[];
    paraW=[];
    paraA=parameters(end-3*k+1:end-2*k);
    paraB=parameters(end-k+1:end);
    paraW=bsxfun(@minus,1,bsxfun(@plus,paraA,paraB));
    errors=[];
   for t=1:262    
    erros=inv(Z)*m_new2(t,:)';
    errors(t,:)=erros';
   end
   
    Ht=cov(errors);
    ht=diag(Ht,0);
    
    ft=errors(end,:,:);
    ft=ft';
    
    htsub1=bsxfun(@times,paraA,ft.^2);
    htsub2=bsxfun(@times,paraB,ht);
    ht1=bsxfun(@plus,paraW,htsub1); 
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1); 
    H_gogarch=Z * Ht1 * Z';  
    Gogarch_Result1(index)=sqrt(weight1'*H_gogarch*weight1);
   if ~isempty(weight2)
        Gogarch_Result2(index)=sqrt(weight2'*H_gogarch*weight2);
   end
    disp(i);
end 
% save Gogarch Result 
save(strcat('../modelResults/',name,'_Gogarch',num2str(p),num2str(o),num2str(q),'_PARAMETERS'),'Equity_Gogarch_PARAMETERS');
save(strcat('../modelResults/',name,'_Gogarch',num2str(p),num2str(o),num2str(q),'_Z'),'Equity_Gogarch_Z');


% ���������ļ�
if ~isempty(weight2)
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(o),num2str(q),'_Every_Defensive'),'Gogarch_Result1');
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(o),num2str(q),'_Every_Offensive'),'Gogarch_Result2');   
else
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(o),num2str(q),'_Every'),'Gogarch_Result1');
end



