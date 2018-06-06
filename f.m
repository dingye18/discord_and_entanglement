function [ y ] = f( x )
%F 此处显示有关此函数的摘要
%   此处显示详细说明
      if(x==1)
          y=0;
      else
        y = ((x+1)/2)*log((x+1)/2)-((x-1)/2)*log((x-1)/2);
      end
end

