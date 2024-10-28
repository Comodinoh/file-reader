module file_reader;

import std::io;
import std::collections::list;

fn String! read(String filename)
{
  String! buffer = (String) file::load_new(filename);

  if(catch excuse = buffer)
  {
    return excuse?;
  }

  return buffer;
}

fn List(<String>) split(String str, char character)
{
  List(<String>) result;
  result.new_init();

  io::printfn("Content size: %d", str.len);

  DString name;

  name.new_init();
  for(int i = 0;i < str.len;i++)
  {
    char c = str[i];

    if(c != character)
    {
      name.append_char(c);
    }
    else
    {
      String str2 = name.copy_str();
      result.push(str2);
      name.clear();
    }
  }
  result.push(name.str_view());

  io::printfn("Line number: %d", result.len());

  return result;
}

fn void! main(String[] args)
{
  // Checking for 2nd term,
  // since the first term in the args is the path of the main file.
  if(args.len < 2)
  {
    io::printfn("Please enter a file name!");
    return;
  }
  String filename = args[1];

  io::printfn("Reading file: %s", filename);

  String! content = read(filename);


  if(catch excuse = content)
  {
    if(excuse = IoError.FILE_NOT_FOUND)
    {
      io::eprintfn("Could not find file: %s", filename);
      return;
    }
    return excuse?;
  }

  content = content.trim();


  List(<String>) list = split(content, '\u000A');

  io::printfn("Splat list: %s", list);
  return;
}
