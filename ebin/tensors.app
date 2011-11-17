{application, tensors,
 [
  {description, "tensors"},
  {vsn, "1.1.0"},
  {modules, [
             tensors_app,
             tensors_io,
             tensors_block,
             tensors_file,
             tensors_tree,
             tensors_tree_utils,
             tensors_put_stream,
             tensors_get_stream,
             tensors_checksum,
             tensors_wm_file
            ]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib,
                  skerl,
                  webmachine,
                  riak_kv
                 ]},
  {mod, { tensors_app, []}},
  {env, []}
 ]}.
