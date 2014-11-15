function [Data,Data2,flag] = LoadData(model,type,name,weightCount)
% ��������
% flag ���سɹ�����ǣ�1���ɹ���0��ʧ��
try  
    flag=1;
    Data=[];
    Data2=[];
    if(weightCount==1)
       tempData=load(strcat('../Result/',name,'_',type,'.mat'));       
       Data=eval(strcat('[tempData.',model,'_Result1];'));     
    elseif(weightCount==2)
       tempData=load(strcat('../Result/',name,'_',type,'_Defensive.mat'));
       Data=eval(strcat('[tempData.',model,'_Result1];'));
       tempData2=load(strcat('../Result/',name,'_',type,'_Offensive.mat'));
       Data2=eval(strcat('[tempData.',model,'_Result2];'));
    end
catch ME
    %error('�ļ�������!');
    flag=0;
end