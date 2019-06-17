clc
clear
%% ============================= 


filename='vldb_ivanovii';


%% =============================

    ball_mode = [1 2 3 4 5];
    ball_rndfix = [0 0 0 0 0];
    ball_seed = [0 0 0 0 0];
    foto_mode = [1 2 3 4 5];
    foto_rndfix = [0 0 0 0 0];
    foto_seed = [0 0 0 0 0];
    
    
ball_mode_param = {'Расстановка #1', 'Расстановка #2', 'Расстановка #3', 'Расстановка #4', 'Расстановка #5', 'Случайное положение'};
ball_rndfix_param = {'off','on'};
foto_mode_param = {'Планарные движения', 'Движения по уровням', 'Продольные наклоны', 'Поперечные наклоны', 'Сложные наклоны', 'Случайная комбинация положений'};
foto_rndfix_param = {'off','on'};    
  
open_system('kr_billiards_exam.slx')
set_param('kr_billiards_exam/My Controller','ModelFile',[filename '.slx'])
result_score=0;
for i=1:5
    disp(['Test#' num2str(i)]) 
    disp(['Размещение шаров: ' ball_mode_param{ball_mode(i)}])
    disp(['Задать фиксированный случайный порядок: ' ball_rndfix_param{ball_rndfix(i)+1}]);
    disp(['Seed: ' num2str(ball_seed(i))]);
    disp(['Перемещение фотокамеры: ' foto_mode_param{foto_mode(i)}]);
    disp(['Задать фиксированный случайный порядок: ' foto_rndfix_param{foto_rndfix(i)+1}]);
    disp(['Seed: ' num2str(foto_seed(i))]);
    [ball_x, ball_y, ball_col] = ball_and_cam_init_allocation(ball_mode(i), ball_rndfix(i), ball_seed(i), foto_mode(i), foto_rndfix(i), foto_seed(i));
    sim('kr_billiards_exam.slx')
    disp(['Score = ' num2str(score)])
    disp('---------------');
    result_score=result_score+score/5;
    disp(' ')
end
disp('========================================')
disp(['         Средний балл: ' num2str(result_score,4)])
disp('========================================')




