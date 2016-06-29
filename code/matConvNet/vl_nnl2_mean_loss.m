function Y = vl_nnl2_mean_loss(X,c,dzdy)
%����Ԥ�������L2��ʧloss = sum((x-c).^2)
%X�����룬c��ground truth��������ʧ����ԣ�dzdyӦ���Ǻ�Xͬά��1����
%ǰ��ʱ��Y�Ǽ���õ���loss������ʱ��Y�Ǽ���õ����ݶ�dzdx
%ǰ��Y = vl_nnl2loss(X,c)��XΪ������D*N��cΪͬά����������YΪʵ��
%����Y = vl_nnl2loss(X,c,dzdy),XΪ��������cΪͬά����������dzdyӦ����1
b = squeeze(X);% X��[1 1 28 100]��С�����
%b(c==0) = 0;%�������൱�ڶ�����Щû�����ĹؽھͲ��������ǵ���ʧ,c��[28 100]��С�����
%����ÿ��ͼ��invisible joint�ĸ���
count = (c~=-0.5);
nc = sum(count,1)/2;
b(c==-0.5) = -0.5;
lamda = 1;
sqrt_lamda = sqrt(lamda);
PX = b(1:14,:); PY = b(15:28,:);
LX = c(1:14,:); LY = c(15:28,:);
tb = [sqrt_lamda*PX; PY]; tc = [sqrt_lamda*LX; LY];
% tb = [PX; PY]; tc = [LX; LY];
tb = reshape(tb,[1,1,size(tb,1),size(tb,2)]);
tc = reshape(tc, [1,1,size(tc,1),size(tc,2)]);
if nargin <= 2
    % forward, calculate the loss
    t_nc = reshape(nc, [1,1,1,size(nc,2)]);% [1 1 1 128]
    Y = sum((tb - tc).^2, 3);
    Y = Y./t_nc; %��ÿ���ؽڵ�ƽ�����
    Y = sum(Y,4); %���ص���һ��batch������loss����˰���ЩlossҪ������
    Y = squeeze(Y);
else
    t_nc = repmat(nc, [28 1]);%[28 100]
    t_nc = reshape(t_nc, [1 1 28 size(nc,2)]);
    Y = 2*(tb - tc)*dzdy;%��ʵ�������dzdyûɶ��,Y��[1 1 28 100]
    Y = Y./t_nc;
end

