/*
    Boost Software License - Version 1.0 - August 17th, 2003

    Permission is hereby granted, free of charge, to any person or organization
    obtaining a copy of the software and accompanying documentation covered by
    this license (the "Software") to use, reproduce, display, distribute,
    execute, and transmit the Software, and to prepare derivative works of the
    Software, and to permit third-parties to whom the Software is furnished to
    do so, all subject to the following:

    The copyright notices in the Software and this entire statement, including
    the above license grant, this restriction and the following disclaimer,
    must be included in all copies of the Software, in whole or in part, and
    all derivative works of the Software, unless such copies or derivative
    works are solely in the form of machine-executable object code generated by
    a source language processor.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
    SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
    FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
*/


#ifndef BOOST_DYNAMIC_CONFIG_MAP_BACKEND_HPP
#define BOOST_DYNAMIC_CONFIG_MAP_BACKEND_HPP
#include <map>
#include <string>
#include <boost/call_traits.hpp>
#include <boost/variant.hpp>
#include "boost/dynamic_config/backend.hpp"
namespace boost {
namespace dynamic_config {
template<typename CharT, typename Value>
class basic_map_backend
{
public:
    typedef std::basic_string<CharT> string_type;
    typedef typename std::basic_string<CharT>::size_type size_type;
    typedef std::map<string_type,Value> map_type;

    size_type erase(string_type key)
    {
        return map_.erase(key);
    }

    void clear()
    {
        map_.clear();
    }

    template<typename T>
    bool insert(string_type const & key, T const & value)
    {
      if (map_.find(key) == map_.end())
      {
	map_[key] = value;
	return true;
      }
      return false;
    }
    
    template<typename T> bool update(string_type const & key, T const & value)
    {
      typename map_type::iterator i = map_.find(key);
      if (i != map_.end())
      {
	i->second = value;
	return true;
      }
      
      return false;
    }
    
    template<typename T> backend::operation_performed replace(string_type const & key, T const & value)
    {
      typename map_type::iterator i = map_.find(key);
      if (i == map_.end())
      {
	map_[key] = value;
	return backend::insert;
      }
      else if (get<T>(i->second) != value)
      {
	i->second = value;
	return backend::update;
      }
      else
      {
	return backend::none;
      }
    }
    
    template<typename T> bool select(string_type const & key, T & value)
    {
      typename map_type::iterator i = map_.find(key);
      if (i != map_.end())
      {
	value = get<T>(i->second);
	return true;
      }
      
      return false;
    }
    
    bool remove(string_type const & key)
    {
      typename map_type::iterator i = map_.find(key);
      if (i != map_.end())
      {
	map_.erase(i);
	return true;
      }
      return false;
    }


private:

    map_type map_;
};

typedef basic_map_backend<char, boost::variant<int, std::string, double > > map_backend;
}
}

#endif // BOOST_DYNAMIC_CONFIG_MAP_BACKEND_HPP
