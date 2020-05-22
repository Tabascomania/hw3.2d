% lkg(노드번호,그룹,1이면 x방향, 2이면 y방향)
i0=1;i1=2;i2=3;

inode = currNode;
ig = currGrp;

for ixy = 1 : 2
  %idir = 3 - ixy;
  idir = ixy;
  lkg(inode, ig, ixy) = (jout(inode, ig, 2, idir) - jin(inode, ig, 2, idir)) / h...
                      + (jout(inode, ig, 1, idir) - jin(inode, ig, 1, idir)) / h;
% 이거 인덱스는 기존 코드에서 잘 맞춰놓은 것 같고. 이건 왜 ixy 대신 idir을 써놨냐
end

% 아 각 방향별(x,y) 평균 lkg. 그래서 0차항인 i0군.
li(inode, ig, i0, 1) = lkg(inode, ig, 1);
li(inode, ig, i0, 2) = lkg(inode, ig, 2);

delh = 1e+6;
% delh = 1 / (nsub * delh);
delh = 1 / (nodeDim * delh);

albedo = [0,Inf,0,Inf];

lpen = 0;
if (~lpen)
  %inb = nb(inode, :);
  
  lkg_xc = lkg(inode, ig, 1); hxl = -1; hxr = 2;
  if (ismember(inode,westNodes)) % west neighboring node
    lkg_xl = 0; hxl = -delh;
    if (albedo(1) == 0); lkg_xl = lkg_xc; hxl = -1; end
    % albedo를 벡터형태로 만들어야겠구만. 알비도가 0이면 리플렉티브인데.
  else
    lkg_xl = lkg(inode-1, ig, 1);
  end
  if (ismember(inode,eastNodes)) % east neighboring node
    lkg_xr = 0; hxr = 1 + delh;
    if (albedo(2) == 0); lkg_xr = lkg_xc; hxr = 2; end
  else
    lkg_xr = lkg(inode+1, ig, 1);
  end
  
  lkg_yc = lkg(inode, ig, 2); hyl = -1; hyr = 2;
  if (ismember(inode,northNodes)) % north neighboring node
    lkg_yl = 0; hyl = -delh;
    if (albedo(3) == 0); lkg_yl = lkg_yc; hyl = -1; end
  else
    lkg_yl = lkg(inode-nodeDim, ig, 2);
  end
  if (ismember(inode,southNodes)) % south neighboring node
    lkg_yr = 0; hyr = 1 + delh;
    if (albedo(4) == 0); lkg_yr = lkg_yc; hyr = 2; end
  else
    lkg_yr = lkg(inode+nodeDim, ig, 2);
  end
  
  ml = [1, 0, 0; 1, 2, -6; 1, -2, -6];
  
  mlx = [1, 0, 0; 1, hxr, (hxr - 2*hxr^2); 1, (hxl - 1), (-1 + 3*hxl -2*hxl^2)];
  vlx = [lkg_xc; lkg_xr; lkg_xl];
  lx = mlx\vlx;
  
  mly = [1, 0, 0; 1, hyr, (hyr - 2*hyr^2); 1, (hyl - 1), (-1 + 3*hyl -2*hyl^2)];
  vly = [lkg_yc; lkg_yr; lkg_yl];
  ly = mly\vly;
  
  li(inode, ig, i1, 1) = lx(i1);
  li(inode, ig, i2, 1) = lx(i2);
  li(inode, ig, i1, 2) = ly(i1);
  li(inode, ig, i2, 2) = ly(i2);
end