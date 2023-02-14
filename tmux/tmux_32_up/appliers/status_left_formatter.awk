function subsplit(main_section_field_str, num_sub_sections, sub_section_idx, sub_section_array, formatted_main_section)
{
  num_sub_sections = split(main_section_field_str, sub_section_array, ",")
  for (sub_section_idx = 1; sub_section_idx <= num_sub_sections; ++sub_section_idx)
  {
    o_parens = split(sub_section_array[sub_section_idx], _, "(") - 1
    c_parens = split(sub_section_array[sub_section_idx], _, ")") - 1
    open += o_parens - c_parens
    o_braces = split(sub_section_array[sub_section_idx], _, "{") - 1
    c_braces = split(sub_section_array[sub_section_idx], _, "}") - 1
    open_braces += o_braces - c_braces
    o_brackets = split(sub_section_array[sub_section_idx], _, "[") - 1
    c_brackets = split(sub_section_array[sub_section_idx], _, "]") - 1
    open_brackets += o_brackets - c_brackets

    if (sub_section_idx == num_sub_sections)
      formatted_main_section = sprintf("%s%s", formatted_main_section, sub_section_array[sub_section_idx])
    else if (open_parens || open_braces || open_brackets)
      formatted_main_section = sprintf("%s%s,", formatted_main_section, sub_section_array[sub_section_idx])
    else
      formatted_main_section = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", formatted_main_section, sub_section_array[sub_section_idx], fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsep)
  }

  gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg_array[format_idx], bg_array[format_idx], attr_array[format_idx]), formatted_main_section)
  return formatted_main_section
}
# Field Separator: "|" (Fields in this case represent the main sections of the tmux status bar)
# num_formats: min of num_formats_fg, num_formats_bg, num_formats_attr
BEGIN {
  FS = "|"
  num_formats_fg = split(fg_, fg_array, ",")
  num_formats_bg = split(bg_, bg_array, ",")
  num_formats_attr = split(attr_, attr_array, ",")
  num_formats = num_formats_fg < num_formats_bg ? (num_formats_fg < num_formats_attr ? num_formats_fg : num_formats_attr) : (num_formats_bg < num_formats_attr ? num_formats_bg : num_formats_attr)
}
{

  # NF: number of fields in a record
  for (field_idx = format_idx = 1; field_idx <= NF; ++field_idx)
  {
    if (open_parens || open_braces || open_brackets)
      printf "|%s", subsplit($field_idx) # $field_idx is the whole field string at index field_idx
    else
    {
      if (field_idx > 1)
        printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg_array[prev_format_idx], bg_array[format_idx], mainsep, fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsplit($field_idx)
      else
        printf "#[fg=%s,bg=%s,%s]%s", fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsplit($field_idx)
    }

    if (!open_parens && !open_braces && !open_brackets)
    {
      prev_format_idx = format_idx
      format_idx = format_idx % num_formats + 1
    }
  }
  printf "#[fg=%s,bg=%s,none]%s", bg_array[prev_format_idx], status_bg, mainsep
}