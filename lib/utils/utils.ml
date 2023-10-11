let read_file_to_string (filepath : string) : string =
  let in_channel = open_in filepath in
  let length = in_channel_length in_channel in
  let byte_seq = Bytes.create length in
  try
    really_input in_channel byte_seq 0 length;
    close_in in_channel;
    Bytes.to_string byte_seq
  with
  | ex ->
    close_in_noerr in_channel;
    raise ex



