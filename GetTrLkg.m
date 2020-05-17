% lkg(����ȣ,�׷�,1�̸� x����, 2�̸� y����)
i0=1;i1=2;i2=3;

for ixy = 1 : 2
  idir = 3 - ixy;
  lkg(inode, ig, ixy) = (jout(inode, ig, 2, idir) - jin(inode, ig, 2, idir)) / h...
                      + (jout(inode, ig, 1, idir) - jin(inode, ig, 1, idir)) / h;
% �̰� �ε����� ���� �ڵ忡�� �� ������� �� ����. �̰� �� ixy ��� idir�� �����
end

% �� �� ���⺰(x,y) ��� lkg. �׷��� 0������ i0��.
li(inode, ig, i0, 1) = lkg(inode, ig, 1);
li(inode, ig, i0, 2) = lkg(inode, ig, 2);

delh = 1e+6;
% delh = 1 / (nsub * delh);
delh = 1 / (nodeDim * delh);

lpen = 0;
if (~lpen)
  inb = nb(inode, :);
  
  lkg_xc = lkg(inode, ig, 1); hxl = -1; hxr = 2;
  if (inb(1) > nxy) % west neighboring node
    lkg_xl = 0; hxl = -delh;
    if (albedo(1) == 0); lkg_xl = lkg_xc; hxl = -1; end
    % albedo�� �������·� �����߰ڱ���. �˺񵵰� 0�̸� ���÷�Ƽ���ε�.
  else
    lkg_xl = lkg(inb(1), ig, 1);
  end
  if (inb(2) > nxy) % east neighboring node
    lkg_xr = 0; hxr = 1 + delh;
    if (albedo(2) == 0); lkg_xr = lkg_xc; hxr = 2; end
  else
    lkg_xr = lkg(inb(2), ig, 1);
  end
  
  lkg_yc = lkg(inode, ig, 2); hyl = -1; hyr = 2;
  if (inb(3) > nxy) % north neighboring node
    lkg_yl = 0; hyl = -delh;
    if (albedo(3) == 0); lkg_yl = lkg_yc; hyl = -1; end
  else
    lkg_yl = lkg(inb(3), ig, 2);
  end
  if (inb(4) > nxy) % south neighboring node
    lkg_yr = 0; hyr = 1 + delh;
    if (albedo(4) == 0); lkg_yr = lkg_yc; hyr = 2; end
  else
    lkg_yr = lkg(inb(4), ig, 2);
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