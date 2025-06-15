import { createRouter, createWebHistory } from 'vue-router'
import { authGuard } from './authGuard'
import HomeView from '@/views/HomeView.vue'
import LoginForm from '@/views/LoginForm.vue'
import CreateUser from '@/views/CreateUser.vue'

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: '/',
			name: 'home',
			component: HomeView,
			meta: { requiresAuth: true },
		},
		{
			path: '/login',
			name: 'Login',
			component: LoginForm,
			meta: { requiresGuest: true },
		},
		{
			path: '/create',
			name: 'Create user',
			component: CreateUser,
			meta: { requiresGuest: true },
		},
		{
			path: '/about',
			name: 'about',
			// route level code-splitting
			// this generates a separate chunk (About.[hash].js) for this route
			// which is lazy-loaded when the route is visited.
			component: () => import('../views/AboutView.vue'),
			meta: { requiresAuth: true },
		},
	],
})

router.beforeEach(authGuard)

export default router
