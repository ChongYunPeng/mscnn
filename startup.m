function startup()
% startup()
% --------------------------------------------------------
% Licensed under The MIT License [see LICENSE for details]
% --------------------------------------------------------

    curdir = fileparts(mfilename('fullpath'));
%    addpath(genpath(fullfile(curdir, 'utils')));
%    addpath(genpath(fullfile(curdir, 'functions')));
%    addpath(genpath(fullfile(curdir, 'bin')));
    addpath(genpath(fullfile(curdir, 'examples')));
%    addpath(genpath(fullfile(curdir, 'imdb')));
    
    addpath(fullfile(curdir, 'data/caltech'));

    addpath(genpath(fullfile(curdir, 'external/toolbox')));
    addpath(genpath(fullfile(curdir,'external/code3.2.1')));

%    caffe_path = fullfile(curdir, 'external', 'caffe', 'matlab');
%    if exist(caffe_path, 'dir') == 0
%        error('matcaffe is missing from external/caffe/matlab; See README.md');
%    end
%    addpath(genpath(caffe_path));

%    mkdir_if_missing(fullfile(curdir, 'imdb', 'cache'));

%    mkdir_if_missing(fullfile(curdir, 'output'));

%    mkdir_if_missing(fullfile(curdir, 'models'));

    fprintf('MSCNN startup done\n');
end