clc
clear all
Template = TemplateImporter(4);
[CopyNumber,Coverage] = CopyNumberImporter(5, 4);
Reads = ReadImporter(1,'SAMEA');

%%% Allignment %%%
Mapping = multialign(Reads(50:80));
seqalignviewer(Mapping)

% nwalign(Template,Reads(1)) % Global
% swalign(Template,Reads(1)) % Local
% seqdotplot(Template,Reads(1)) % Visualization
%%% Mapping %%%
% R = StringToVector(Reads); T = StringToVector(Template); % our method
%[Template_C,Internal_C] = HammingCoverage(T,R1,2);

% bowtiebuild('Template.fna','Template')
% Reads = which('SAMEA2533380.fq')
% bowtie(Template, Reads, Mapping)
% Result = BioMap('Mapping.bam')
