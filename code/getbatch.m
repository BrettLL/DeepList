function im_batch = getbatch(imdb, id_batch)
% ÿ��id���ѡ4��ͼ�����
id = imdb.id;
% index = zeros(size(id));
index = [];
for i=1:numel(id_batch)
    b = find(id == id_batch(i));
    index = [index, b];
end
im_batch = imdb.data(:,:,:,index);