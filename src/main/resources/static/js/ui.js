class UIComponents {
    // Navigation
    static initNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const page = link.getAttribute('data-page');
                UIComponents.showPage(page);

                // Update active state
                navLinks.forEach(l => l.classList.remove('active'));
                link.classList.add('active');
            });
        });
    }

    static showPage(pageId) {
        // Hide all pages
        document.querySelectorAll('.page').forEach(page => {
            page.classList.remove('active');
        });

        // Show selected page
        const targetPage = document.getElementById(`${pageId}-page`);
        if (targetPage) {
            targetPage.classList.add('active');
            UIComponents.loadPageData(pageId);
        }
    }

    static async loadPageData(pageId) {
        const loading = document.getElementById('loading');
        loading.style.display = 'block';

        try {
            switch (pageId) {
                case 'dashboard':
                    await App.loadDashboard();
                    break;
                case 'caisses':
                    await App.loadCaisses();
                    break;
                case 'tests':
                    await App.loadTests();
                    break;
            }
        } catch (error) {
            UIComponents.showError('Erreur lors du chargement des données');
        } finally {
            loading.style.display = 'none';
        }
    }

    // Loading states
    static showLoading(element) {
        element.innerHTML = `
            <div class="loading">
                <div class="spinner"></div>
                <p>Chargement...</p>
            </div>
        `;
    }

    static hideLoading() {
        const loading = document.getElementById('loading');
        if (loading) {
            loading.style.display = 'none';
        }
    }

	// Messages
	static showError(message) {
	    showNotification(`❌ ${message}`, 'error');
	}

	static showSuccess(message) {
	    showNotification(`✅ ${message}`, 'success');
	}

    // Modal management
    static showModal(html) {
        const modalId = 'dynamic-modal';
        let modal = document.getElementById(modalId);

        if (!modal) {
            modal = document.createElement('div');
            modal.id = modalId;
            modal.className = 'modal';
            modal.innerHTML = html;
            document.getElementById('modals-container').appendChild(modal);
        } else {
            modal.innerHTML = html;
        }

        modal.style.display = 'block';

        // Close modal on background click
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                UIComponents.hideModal();
            }
        });

        // Close modal on X click
        const closeBtn = modal.querySelector('.close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                UIComponents.hideModal();
            });
        }
    }

    static hideModal() {
        const modal = document.getElementById('dynamic-modal');
        if (modal) {
            modal.style.display = 'none';
        }
    }

    // Form handling
    static getFormData(formId) {
        const form = document.getElementById(formId);
        const formData = new FormData(form);
        const data = {};

        for (let [key, value] of formData.entries()) {
            // Convert boolean values
            if (value === 'true') data[key] = true;
            else if (value === 'false') data[key] = false;
            // Convert number values
            else if (!isNaN(value) && value !== '') data[key] = Number(value);
            else data[key] = value;
        }

        return data;
    }
}