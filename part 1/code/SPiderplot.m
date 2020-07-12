
t = tiledlayout(2,2);
D1 = [0.486254276356883;0.0715216813435783;-0.409662003746216;0.587261402304320;0.495724233695137];
D2 = [0.408623397508983;0.743271496312495;0.526241504914444;-0.0603443221131738;-0.00168614106285830];
D3 = [-0.260624654652987;-0.0902613875937925;0.298837590558908;-0.294698479752940;0.864740754097381]
D4 = [-0.551737303780999;0.658994686684981;-0.505839933634251;-0.0322579607179062;0.0663124124780326]
D5 = [-0.473544543560946;-0.00331914112087115;0.458332823613868;0.750729537286161;-0.0456150546434115]
P = [D1 D2 D3 D4 D5];


% Spider plot
spider_plot_R2019b(P);
legend('D1', 'D2', 'D3', 'D4', 'D5', 'Location', 'southoutside');