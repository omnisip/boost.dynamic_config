#ifndef BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP
#define BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP 1
//
//  property_config.hpp -- Main class for property_configuration
//
//  Copyright (C) 2011 Dan Weber <dan@marketsoup.com>
//
// Distributed under the Boost Software License, Version 1.0. (See
// accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)
//
//
#include <boost/config.hpp>
#include <boost/detail/workaround.hpp>
#include <boost/noncopyable.hpp>
#include <boost/dynamic_config/backend.hpp>
#include <boost/call_traits.hpp>
#include <string>
#include <boost/cstdint.hpp>

namespace boost {
namespace dynamic_config {
template <typename Backend, typename Mutex>
class basic_property_config : boost::noncopyable {
    typedef typename Mutex::scoped_lock scoped_lock;
public:
    typedef typename Backend::string_type string_type;
    typedef typename Backend::size_type size_type;

    /// Constructors
    basic_property_config() {}
    basic_property_config(string_type const & organizationName, string_type const & applicationName) : backend_(organizationName, applicationName) 
    {}

    ~basic_property_config() {}

    size_type erase(string_type key)
    {
      scoped_lock lk(mutex_);
      return backend_.erase(key);
    }
    
    void clear()
    {
      scoped_lock lk(mutex_);
      backend_.clear();
    }
    
    
    template<typename T> bool insert(string_type const & key, T const & value)
    {
      scoped_lock lk(mutex_);
      return backend_.insert(key,value);
    }
    
    
    template<typename T> bool update(string_type const & key, T const & value)
    {
      scoped_lock lk(mutex_);
      return backend_.update(key,value);
    }
    
    template<typename T> backend::operation_performed replace(string_type const & key, T const & value)
    {
      scoped_lock lk(mutex_);
      return backend_.replace(key,value);
    }
    
    template<typename T> bool select(string_type const & key, T & value)
    {
      scoped_lock lk(mutex_);
      return backend_.select(key,value);
    }
    
    bool remove(string_type const & key)
    {
      scoped_lock lk(mutex_);
      return backend_.remove(key);
    }
    
private:
  Backend backend_;
  Mutex mutex_;

};




} // dynamic_config
} // boost


#endif // BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP
