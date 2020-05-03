# filename_increment
Please consider starring the project to show your heart and support.

Project is based on this [repo](https://github.com/jonschlinkert/add-filename-increment), show him some love please ;).
>When copying or moving files, it's common for operating systems to automatically 
>add an increment or 'copy' to duplicate file names. This does that for Ruby applications, with automatic platform 
>detection and support for Linux, MacOs, and Windows conventions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filename_increment'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install filename_increment

## Usage
All methods automatically detect the platform to use, unless platform is defined on the options.

```ruby
FilenameIncrement.new('foo/bar.txt', platform: 'linux').to_s
# foo/bar (copy).txt
FilenameIncrement.new('foo/bar.txt', platform: 'win32').to_s
# foo/bar (2).txt
FilenameIncrement.new('foo/bar.txt', platform: 'darwin').to_s
# foo/bar copy.txt
```

## Options

### options.fs

**Description**: Check the file system, and automatically increment the file based on existing files. Thus, if the file name is `foo.txt`, and `foo (2).txt` already exists, the file will automatically be renamed to `foo (3).txt`.

Also uses the correct conventions for Linux, Windows (win32), and MacOS (darwin).

**Type**: `boolean`

**Default**: `nil`

### options.platform

**Description**: Specify the platform conventions to use.

**Type**: `String`

**Default**: Uses `Gem::Platform.local.os`. Valid values are `linux`, `win32` and `darwin`.

## Operating Systems

* [Linux](#linux)
* [MacOS](#macos)
* [Windows](#windows)

**Supported Operating Systems**

Currently Windows, Darwin (MacOS), and Linux are supported. This library attempts to automatically use the correct conventions for each operating system. Please [create an issue](../../issues/new) if you ecounter a bug.

If you use an operating system with different conventions, and you would like for this library to add support, please [create an issue](../../issues/new) with a detailed description of those conventions, or feel free to do a [pull request](.github/contributing.md).

### Linux

When a file is copied or moved, and the destination file path already exists, Linux uses the following conventions for incrementing the file name.

| **Source path** | **Destination path** | **Type** | **Directory<sup>1</sup>** |
| --- | --- | --- | --- |
| `foo.txt` | `foo (copy).txt`, `foo (another copy).txt`, `foo (3rd copy).txt`, ... | file | Same directory as source |
| `foo` | `foo (copy)`, `foo (another copy)`, `foo (3rd copy)`, ... | directory | Same directory as source |

<small><sup>1</sup> _On Linux, when a file or folder is copied or moved to a different directory and another file or folder with the same name exists in that directory, you are prompted to choose a new name for the file or folder, or to cancel or skip the operation._ </small>

### MacOS

When a file is copied or moved, and the destination file path already exists, MacOS uses the following conventions for incrementing the file name.

| **Source path** | **Destination path** | **Type** | **Directory<sup>1</sup>** |
| --- | --- | --- | --- |
| `foo.txt` | `foo copy.txt`, `foo copy 2.txt`, ... | file | Same directory as source |
| `foo.txt` | `foo 2.txt`, `foo 3.txt`, ... | file | Different directory than source |
| `foo` | `foo copy`, `foo copy 2`, ... | directory | Same directory as source |

<small><sup>1</sup> _MacOS uses different conventions for incrementing file names when the source file is copied, moved or renamed to a different directory, versus when the file is copied into the same directory._ </small>

### Windows

When a file is copied or moved, and the destination file path already exists, Windows uses the following conventions for incrementing the file name.

| **Source path** | **Destination path** | **Type** | **Directory<sup>1</sup>** |
| --- | --- | --- | --- |
| `foo.txt` | `foo - Copy.txt` | file | Same directory as source |
| `foo.txt` | `foo (2).txt` | file | Different directory than source |
| `foo (2).txt` | `foo (3).txt` | file | Different directory than source |
| `foo` | `foo - Copy` | directory | Same directory as source |
| `foo - Copy` | `foo - Copy (2)` | directory | Same directory as source |

<small><sup>1</sup> _Windows uses different conventions for incrementing file names when the source file is copied, moved or renamed to a different directory, versus when the file is copied into the same directory. Also, when a folder is copied to a new directory, and the new directory already has a folder with the same name, Windows just merges the folders automatically._ </small>


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FilenameIncrement project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/filename_increment/blob/master/CODE_OF_CONDUCT.md).
