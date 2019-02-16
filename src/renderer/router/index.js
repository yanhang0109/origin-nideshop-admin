import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  scrollBehavior: () => ({y: 0}),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      redirect: '/dashboard'
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      components: require('@/components/DashboardPage'),
      children: [
        {
          path: '/',
          name: 'welcome',
          components: require('@/components/WelcomePage')
        },
        {
          path: 'goods',
          name: 'goods',
          components: require('@/components/Goods/GoodsPage')
        },
        {
          path: 'goods/add',
          name: 'goods_add',
          components: require('@/components/Goods/GoodsAddPage')
        },
        {
          path: 'category',
          name: 'category',
          components: require('@/components/Category/CategoryPage')
        },
        {
          path: 'category/add',
          name: 'category_add',
          components: require('@/components/Category/CategoryAddPage')
        },
        {
          path: 'brand',
          name: 'brand',
          components: require('@/components/Brand/BrandPage')
        },
        {
          path: 'brand/add',
          name: 'brand_add',
          components: require('@/components/Brand/BrandAddPage')
        },
        {
          path: 'order',
          name: 'order',
          components: require('@/components/Order/OrderPage')
        },
        {
          path: 'order/detail',
          name: 'order_detail',
          components: require('@/components/Order/OrderDetailPage')
        },
        {
          path: 'group',
          name: 'group',
          components: require('@/components/Group/GroupPage')
        },
        {
          path: 'group/add',
          name: 'group_add',
          components: require('@/components/Group/GroupAddPage')
        },
        {
          path: 'operate/topic',
          name: 'topic',
          components: require('@/components/Topic/TopicPage')
        },
        {
          path: 'operate/topic/add',
          name: 'topic_add',
          components: require('@/components/Topic/TopicAddPage')
        },
        {
          path: 'user',
          name: 'user',
          components: require('@/components/User/UserPage')
        },
        {
          path: 'user/add',
          name: 'user_add',
          components: require('@/components/User/UserAddPage')
        }
      ]
    },
    {
      path: '/login',
      name: 'login',
      components: require('@/components/LoginPage')
    },
    {
      path: '*',
      redirect: '/dashboard'
    }
  ]
})
