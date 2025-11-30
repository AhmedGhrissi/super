class App {
    static async init() {
        UIComponents.initNavigation();
        await this.loadDashboard();
    }

    static async loadDashboard() {
        try {
            const data = await apiService.getDashboard();
            this.renderDashboard(data);
        } catch (error) {
            UIComponents.showError('Erreur lors du chargement du dashboard');
        }
    }

    static renderDashboard(data) {
        // Stats cards
        const statsHtml = `
            <div class="stat-card">
                <h3>Total Caisses</h3>
                <div class="value">${data.totalCaisses}</div>
            </div>
            <div class="stat-card">
                <h3>Caisses Actives</h3>
                <div class="value">${data.caissesActivesCount}</div>
            </div>
            <div class="stat-card">
                <h3>Tests Actifs</h3>
                <div class="value">${data.testsActifs.length}</div>
            </div>
        `;
        document.getElementById('stats-cards').innerHTML = statsHtml;

        // Caisses list
        const caissesHtml = data.caissesActives.map(caisse => `
            <div class="list-item">
                <h4>${caisse.code} - ${caisse.nom}</h4>
                <p>Partition: ${caisse.codePartition} | CR: ${caisse.codeCr}</p>
                <span class="status-${caisse.actif ? 'active' : 'inactive'}">
                    ${caisse.actif ? 'Actif' : 'Inactif'}
                </span>
            </div>
        `).join('');
        document.getElementById('caisses-list').innerHTML = caissesHtml;

        // Tests list
        const testsHtml = data.testsActifs.map(test => `
            <div class="list-item">
                <h4>${test.description}</h4>
                <p>${test.endpoint}:${test.port} | ${test.validationType}</p>
                <span class="status-${test.actif ? 'active' : 'inactive'}">
                    ${test.actif ? 'Actif' : 'Inactif'}
                </span>
            </div>
        `).join('');
        document.getElementById('tests-list').innerHTML = testsHtml;
    }

    static async loadCaisses() {
        try {
            const caisses = await apiService.getCaisses();
            this.renderCaissesTable(caisses);
        } catch (error) {
            UIComponents.showError('Erreur lors du chargement des caisses');
        }
    }

    static renderCaissesTable(caisses) {
        const html = `
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Nom</th>
                            <th>Partition</th>
                            <th>CR</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${caisses.map(caisse => `
                            <tr>
                                <td>${caisse.code}</td>
                                <td>${caisse.nom}</td>
                                <td>${caisse.codePartition}</td>
                                <td>${caisse.codeCr}</td>
                                <td>
                                    <span class="status-${caisse.actif ? 'active' : 'inactive'}">
                                        ${caisse.actif ? 'Actif' : 'Inactif'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-primary" onclick="App.editCaisse(${caisse.id})">
                                        Modifier
                                    </button>
                                    <button class="btn btn-danger" onclick="App.deleteCaisse(${caisse.id})">
                                        Supprimer
                                    </button>
                                </td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
        `;
        document.getElementById('caisses-table-container').innerHTML = html;
    }

    static async loadTests() {
        try {
            const tests = await apiService.getTests();
            this.renderTestsTable(tests);
        } catch (error) {
            UIComponents.showError('Erreur lors du chargement des tests');
        }
    }

    static renderTestsTable(tests) {
        const html = `
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Endpoint</th>
                            <th>Port</th>
                            <th>Type</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${tests.map(test => `
                            <tr>
                                <td>${test.description}</td>
                                <td>${test.endpoint}</td>
                                <td>${test.port}</td>
                                <td>${test.validationType}</td>
                                <td>
                                    <span class="status-${test.actif ? 'active' : 'inactive'}">
                                        ${test.actif ? 'Actif' : 'Inactif'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-primary" onclick="App.editTest(${test.id})">
                                        Modifier
                                    </button>
                                    <button class="btn btn-danger" onclick="App.deleteTest(${test.id})">
                                        Supprimer
                                    </button>
                                </td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
        `;
        document.getElementById('tests-table-container').innerHTML = html;
    }

    // Modal functions
    static showCreateCaisseModal() {
        const modalHtml = `
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Nouvelle Caisse</h3>
                    <button class="close">&times;</button>
                </div>
                <form id="create-caisse-form">
                    <div class="form-group">
                        <label for="code">Code *</label>
                        <input type="text" id="code" name="code" required>
                    </div>
                    <div class="form-group">
                        <label for="nom">Nom *</label>
                        <input type="text" id="nom" name="nom" required>
                    </div>
                    <div class="form-group">
                        <label for="codePartition">Partition</label>
                        <input type="text" id="codePartition" name="codePartition">
                    </div>
                    <div class="form-group">
                        <label for="codeCr">Code CR</label>
                        <input type="text" id="codeCr" name="codeCr">
                    </div>
                    <div class="form-group">
                        <label for="actif">Actif</label>
                        <select id="actif" name="actif">
                            <option value="true">Oui</option>
                            <option value="false">Non</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn" onclick="UIComponents.hideModal()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Créer</button>
                    </div>
                </form>
            </div>
        `;

        UIComponents.showModal(modalHtml);

        document.getElementById('create-caisse-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            await this.createCaisse();
        });
    }

    static async createCaisse() {
        try {
            const data = UIComponents.getFormData('create-caisse-form');
            await apiService.createCaisse(data);
            UIComponents.hideModal();
            UIComponents.showSuccess('Caisse créée avec succès');
            await this.loadCaisses();
        } catch (error) {
            UIComponents.showError('Erreur lors de la création de la caisse');
        }
    }

    static async deleteCaisse(id) {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette caisse ?')) {
            try {
                await apiService.deleteCaisse(id);
                UIComponents.showSuccess('Caisse supprimée avec succès');
                await this.loadCaisses();
            } catch (error) {
                UIComponents.showError('Erreur lors de la suppression de la caisse');
            }
        }
    }

    static showCreateTestModal() {
        const modalHtml = `
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Nouveau Test</h3>
                    <button class="close">&times;</button>
                </div>
                <form id="create-test-form">
                    <div class="form-group">
                        <label for="code">Code</label>
                        <input type="text" id="code" name="code">
                    </div>
                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="endpoint">Endpoint *</label>
                        <input type="text" id="endpoint" name="endpoint" required>
                    </div>
                    <div class="form-group">
                        <label for="port">Port</label>
                        <input type="number" id="port" name="port" value="80">
                    </div>
                    <div class="form-group">
                        <label for="validationType">Type de Validation</label>
                        <select id="validationType" name="validationType">
                            <option value="STATUS_CODE">Status Code</option>
                            <option value="RESPONSE_TEXT">Response Text</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="statusAttendu">Status Attendu</label>
                        <input type="number" id="statusAttendu" name="statusAttendu" value="200">
                    </div>
                    <div class="form-group">
                        <label for="actif">Actif</label>
                        <select id="actif" name="actif">
                            <option value="true">Oui</option>
                            <option value="false">Non</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn" onclick="UIComponents.hideModal()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Créer</button>
                    </div>
                </form>
            </div>
        `;

        UIComponents.showModal(modalHtml);

        document.getElementById('create-test-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            await this.createTest();
        });
    }

    static async createTest() {
        try {
            const data = UIComponents.getFormData('create-test-form');
            await apiService.createTest(data);
            UIComponents.hideModal();
            UIComponents.showSuccess('Test créé avec succès');
            await this.loadTests();
        } catch (error) {
            UIComponents.showError('Erreur lors de la création du test');
        }
    }

    static async deleteTest(id) {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce test ?')) {
            try {
                await apiService.deleteTest(id);
                UIComponents.showSuccess('Test supprimé avec succès');
                await this.loadTests();
            } catch (error) {
                UIComponents.showError('Erreur lors de la suppression du test');
            }
        }
    }
}

// Initialize app when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    App.init();
});