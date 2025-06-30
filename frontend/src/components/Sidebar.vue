<script setup lang="ts">
import { RouterLink } from 'vue-router'
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useSidebarStore } from '@/stores/sidebar'
import { onClickOutside } from '@vueuse/core'
import NavlinkComponent from '@/components/NavlinkComponent.vue'

const navLinks = [
	{ name: 'Home', to: '/', icon: 'fas fa-home' },
	{ name: 'About', to: '/about' },
]

const sidebarStore = useSidebarStore()
const sidebarRef = ref(null)

onClickOutside(sidebarRef, () => {
	sidebarStore.close()
})
</script>

<template>
	<div
		class="sidebar has-background-grey is-100"
		:class="{ 'is-open': sidebarStore.isOpen }"
		ref="sidebarRef"
	>
		<aside class="menu">
			<p class="menu-label">Menu</p>
			<ul class="menu-list">
				<NavlinkComponent
					v-for="link in navLinks"
					:name="link.name"
					:to="link.to"
					:icon="link.icon"
				/>
			</ul>
		</aside>
	</div>
</template>

<style lang="scss">
@use 'bulma/sass/utilities/initial-variables' as iv;
@use 'bulma/sass/utilities/derived-variables' as dv;

@media screen and (max-width: iv.$tablet) {
	.sidebar {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		width: 250px;
		z-index: 100;
		transition: transform 0.3s ease;
		transform: translateX(-100%);
		// background-color: dv.$background;
	}

	.sidebar.is-open {
		transform: translateX(0);
	}
}
</style>
