function Y = vl_nnl2loss(X,c,dzdy)
%����Ԥ�������L2��ʧloss = sum((x-c).^2)
%X�����룬c��ground truth��������ʧ����ԣ�dzdyӦ���Ǻ�Xͬά��1����
%ǰ��ʱ��Y�Ǽ���õ���loss������ʱ��Y�Ǽ���õ����ݶ�dzdx
%ǰ��Y = vl_nnl2loss(X,c)��XΪ������D*N��cΪͬά����������YΪʵ��
%����Y = vl_nnl2loss(X,c,dzdy),XΪ��������cΪͬά����������dzdyӦ����1
b = squeeze(X);% X��[1 1 28 100]��С�����
%b(c==0) = 0;%�������൱�ڶ�����Щû�����ĹؽھͲ��������ǵ���ʧ,c��[28 100]��С�����
b(c==-0.5) = -0.5;
b = reshape(b,[1,1,size(b,1),size(b,2)]);
c = reshape(c, [1,1,size(c,1),size(c,2)]);
if nargin <= 2
    % forward, calculate the loss
    Y = sum((b - c).^2, 3);
    Y = sum(Y,4); %���ص���һ��batch������loss����˰���ЩlossҪ������
    Y = squeeze(Y);
else
    Y = 2*(b - c)*dzdy;%��ʵ�������dzdyûɶ��
end

