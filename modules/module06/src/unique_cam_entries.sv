property unique_cam_entries;
  @(posedge clk)
    cam_insert & (cam_tag == prev_cam_tag) |-> ##0 error_flag == 1;
endproperty

assert property (unique_cam_entries);
